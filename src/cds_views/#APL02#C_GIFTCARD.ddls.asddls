@EndUserText.label: 'Gift Card Details - Consumption View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define root view entity /APL02/C_GIFTCARD
  provider contract transactional_query
  as projection on /APL02/I_GIFTCARD
{
  key SapUUID,
      Giftcardnumber,
      SapDescription,
      @Semantics.amount.currencyCode: 'AmountC'
      AmountV,
      AmountC,
      LocalLastChanged,
      LastChanged
}
