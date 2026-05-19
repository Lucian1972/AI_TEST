@EndUserText.label : 'Gift Card Details - Draft Table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table /apl02/giftcard_d {
  key mandt             : abap.clnt not null;
  key sapuuid           : sysuuid_x16 not null;
  giftcardnumber        : /apl02/giftcardnumber;
  sapdescription        : /apl02/giftcarddesc;
  @Semantics.amount.currencyCode : '/apl02/giftcard_d.amountc'
  amountv               : /apl02/giftcardamt;
  amountc               : abap.cuky;
  locallastchanged      : abp_locinst_lastchange_tstmpl;
  lastchanged           : abp_lastchange_tstmpl;
  "%admin" : include sych_bdl_draft_admin_inc;
}
