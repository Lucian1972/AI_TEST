@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gift Card Details - Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #A,
  sizeCategory: #S,
  dataClass: #MASTER
}
define root view entity /APL02/I_GIFTCARD
  as select from /apl02/giftcard
{
  key sap_uuid                                    as SapUUID,
      giftcardnumber                              as Giftcardnumber,
      sap_description                             as SapDescription,
      @Semantics.amount.currencyCode: 'AmountC'
      amount_v                                    as AmountV,
      @Semantics.currencyCode: true
      amount_c                                    as AmountC,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed                          as LocalLastChanged,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed                                as LastChanged
}
