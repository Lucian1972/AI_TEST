@EndUserText.label : 'Gift Card Details'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table /apl02/giftcard {
  key client            : abap.clnt not null;
  key sap_uuid          : sysuuid_x16 not null;
  giftcardnumber        : /apl02/giftcardnumber not null;
  sap_description       : /apl02/giftcarddesc not null;
  @Semantics.amount.currencyCode : '/apl02/giftcard.amount_c'
  amount_v              : /apl02/giftcardamt;
  amount_c              : abap.cuky;
  local_last_changed    : abp_locinst_lastchange_tstmpl;
  last_changed          : abp_lastchange_tstmpl;
}
