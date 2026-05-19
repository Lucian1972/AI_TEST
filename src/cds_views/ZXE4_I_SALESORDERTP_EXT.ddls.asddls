extend view entity I_SALESORDERTP with {
  @Semantics.amount.currencyCode: 'zz_giftcardcurrency_sdh'
  SalesOrder.zz_giftcardamount_sdh   as zz_giftcardamount_sdh,
  SalesOrder.zz_giftcardcurrency_sdh as zz_giftcardcurrency_sdh
}
