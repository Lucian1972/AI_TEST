@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gift Card Value Help'
@ObjectModel.usageType:{
  serviceQuality: #A,
  sizeCategory: #L,
  dataClass: #MASTER
}
@ObjectModel.dataCategory: #VALUE_HELP
@Search: {
  searchable: true
}
@ObjectModel.representativeKey: 'SapUUID'
@Consumption.valueHelpDefault.fetchValues: #AUTOMATICALLY_WHEN_DISPLAYED
@Consumption.ranked: true
define view entity ZXE4_GIFTCARDVH
  as select from ZXE4_I_GIFTCARD as GiftCard
{
  @UI.hidden: true
  key GiftCard.SapUUID,
      @ObjectModel.text.element: ['SapDescription']
      GiftCard.Giftcardnumber,
      @Search: {
        defaultSearchElement: true,
        ranking: #HIGH,
        fuzzinessThreshold: 0.8
      }
      @Semantics.text: true
      GiftCard.SapDescription
}
