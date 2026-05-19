*"* use this source file for the definition and implementation of
*"* local helper classes, interface implementations and type
*"* definitions

"----------------------------------------------------------------------
" Local handler for GiftCard entity (ZXE4_I_GIFTCARD)
"----------------------------------------------------------------------
CLASS lhc_giftcard DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR GiftCard RESULT result.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR GiftCard RESULT result.
ENDCLASS.

CLASS lhc_giftcard IMPLEMENTATION.
  METHOD get_instance_features.
    result = CORRESPONDING #( keys ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.
ENDCLASS.
