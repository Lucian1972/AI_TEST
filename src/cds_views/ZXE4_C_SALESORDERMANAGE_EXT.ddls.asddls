@EndUserText.label: 'Sales Order Projection View Extension'
extend view C_SalesOrderManage with ZXE4_C_SALESORDERMANAGE_EXT
  association [0..1] to I_Currency as _zz_giftcardcurrency_sdh
    on $projection.zz_giftcardcurrency_sdh = _zz_giftcardcurrency_sdh.Currency
{
  @Semantics.amount.currencyCode: 'zz_giftcardcurrency_sdh'
  @UI: {
    fieldGroup: [{ qualifier: 'OrderData',
                   importance: #HIGH,
                   type: #FOR_ACTION,
                   dataAction: 'zz_use_gift_card',
                   label: 'Use Gift Card' }]
  }
  @UI.lineItem: [{ position: 65, importance: #HIGH }]
  SalesOrder.zz_giftcardamount_sdh   as zz_giftcardamount_sdh,
  @ObjectModel.foreignKey.association: '_zz_giftcardcurrency_sdh'
  SalesOrder.zz_giftcardcurrency_sdh as zz_giftcardcurrency_sdh,

  _zz_giftcardcurrency_sdh
}
