@EndUserText.label : 'Gift Card Details - Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zxe4_giftcard_d {
  key mandt             : abap.clnt not null;
  key sapuuid           : sysuuid_x16 not null;
  giftcardnumber        : zxe4_giftcardnumber;
  sapdescription        : zxe4_giftcarddesc;
  @Semantics.amount.currencyCode : 'zxe4_giftcard_d.amountc'
  amountv               : zxe4_giftcardamt;
  amountc               : abap.cuky;
  locallastchanged      : abp_locinst_lastchange_tstmpl;
  lastchanged           : abp_lastchange_tstmpl;
  "%admin" : include sych_bdl_draft_admin_inc;
}
