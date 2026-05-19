@EndUserText.label : 'Sales Order Extension for Gift Card Fields'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
extend type sdsalesdoc_incl_eew_ps with /apl02/salesorder_append {
  @Semantics.amount.currencyCode : '/apl02/salesorder_append.zz_giftcardcurrency_sdh'
  zz_giftcardamount_sdh   : /apl02/giftcardamt;
  zz_giftcardcurrency_sdh : abap.cuky;
}
