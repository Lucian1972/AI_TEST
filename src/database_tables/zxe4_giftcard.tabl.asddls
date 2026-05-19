@EndUserText.label : 'Gift Card Details'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zxe4_giftcard {
  key client            : abap.clnt not null;
  key sap_uuid          : sysuuid_x16 not null;
  giftcardnumber        : zxe4_giftcardnumber not null;
  sap_description       : zxe4_giftcarddesc not null;
  @Semantics.amount.currencyCode : 'zxe4_giftcard.amount_c'
  amount_v              : zxe4_giftcardamt;
  amount_c              : abap.cuky;
  local_last_changed    : abp_locinst_lastchange_tstmpl;
  last_changed          : abp_lastchange_tstmpl;
}
