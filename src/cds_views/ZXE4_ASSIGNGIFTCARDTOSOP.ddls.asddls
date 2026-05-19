@EndUserText.label: 'Sales Order Gift Card'
define abstract entity ZXE4_ASSIGNGIFTCARDTOSOP {
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZXE4_GIFTCARDVH',
      element: 'Giftcardnumber'
    }
  }]
  @EndUserText.label: 'Gift Card'
  Giftcardnumber : zxe4_giftcardnumber;
}
