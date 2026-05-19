*"* use this source file for the definition and implementation of
*"* local helper classes, interface implementations and type
*"* definitions

"----------------------------------------------------------------------
" Local handler for Sales Order extension (ZXE4_GIFTCARD_EXT)
" - Implements the zz_use_gift_card action on SalesOrder
" - Enables the action only when TotalNetAmount >= 50 EUR
" - Deducts the gift card value via a DRV1 pricing element
"----------------------------------------------------------------------
CLASS lhc_salesorder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR SalesOrder RESULT result.
    METHODS zz_use_gift_card FOR MODIFY
      IMPORTING it_keys FOR ACTION SalesOrder~zz_use_gift_card RESULT result.
ENDCLASS.

CLASS lhc_salesorder IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF I_SalesOrderTP IN LOCAL MODE
      ENTITY SalesOrder
        FIELDS ( TotalNetAmount )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result_salesorder).

    result = VALUE #(
      FOR ls_salesorder IN lt_result_salesorder
        ( %tky = ls_salesorder-%tky
          %features-%action-zz_use_gift_card =
            COND #( WHEN ls_salesorder-TotalNetAmount < '50'
                    THEN if_abap_behv=>fc-o-disabled
                    ELSE if_abap_behv=>fc-o-enabled ) ) ).
  ENDMETHOD.

  METHOD zz_use_gift_card.
    " Read the matching gift card record
    SELECT giftcardnumber, amount_v, amount_c
      FROM zxe4_giftcard
      FOR ALL ENTRIES IN @it_keys
      WHERE giftcardnumber = @it_keys-%param-Giftcardnumber
      INTO TABLE @DATA(lt_discount).

    " Apply gift card discount to each sales order
    LOOP AT it_keys REFERENCE INTO DATA(lr_key).
      READ TABLE lt_discount INTO DATA(ls_discount)
        WITH KEY giftcardnumber = lr_key->%param-Giftcardnumber.
      CHECK ls_discount IS NOT INITIAL.

      MODIFY ENTITIES OF i_salesordertp IN LOCAL MODE
        ENTITY salesorder
          UPDATE SET FIELDS WITH VALUE #(
            ( %tky                          = lr_key->%tky
              %data-zz_giftcardamount_sdh   = ls_discount-amount_v
              %data-zz_giftcardcurrency_sdh = ls_discount-amount_c ) )
        CREATE BY \_pricingelement SET FIELDS WITH VALUE #(
          ( %tky    = lr_key->%tky
            %target = VALUE #( (
              %cid                = 'CIDGIFTCARD'
              conditiontype       = 'DRV1'
              conditionrateamount = ls_discount-amount_v * ( -1 )
              conditioncurrency   = ls_discount-amount_c ) ) ) )
        FAILED   DATA(ls_modify_failed)
        REPORTED DATA(ls_modify_reported).

      failed   = CORRESPONDING #( APPENDING BASE ( failed )   ls_modify_failed ).
      reported = CORRESPONDING #( APPENDING BASE ( reported ) ls_modify_reported ).
    ENDLOOP.

    " Return updated sales order as action result
    READ ENTITIES OF i_salesordertp IN LOCAL MODE
      ENTITY salesorder
        ALL FIELDS WITH CORRESPONDING #( it_keys )
      RESULT DATA(lt_salesorder).

    result = VALUE #(
      FOR salesorder IN lt_salesorder
        ( %tky   = salesorder-%tky
          %param = CORRESPONDING #( salesorder ) ) ).
  ENDMETHOD.

ENDCLASS.

"----------------------------------------------------------------------
" Behavior saver
"----------------------------------------------------------------------
CLASS lsc_r_salesordertp DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS cleanup_finalize REDEFINITION.
ENDCLASS.

CLASS lsc_r_salesordertp IMPLEMENTATION.
  METHOD cleanup_finalize.
  ENDMETHOD.
ENDCLASS.
