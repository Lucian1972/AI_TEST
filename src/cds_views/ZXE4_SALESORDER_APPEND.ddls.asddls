@EndUserText.label : 'Sales Order Extension for Gift Card Fields'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
extend type sdsalesdoc_incl_eew_ps with zxe4_salesorder_append {
  @Semantics.amount.currencyCode : 'zxe4_salesorder_append.zz_giftcardcurrency_sdh'
  zz_giftcardamount_sdh   : zxe4_giftcardamt;
  zz_giftcardcurrency_sdh : abap.cuky;
}
