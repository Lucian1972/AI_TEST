@EndUserText.label: 'Sales Order Gift Card'
define abstract entity /APL02/ASSIGNGIFTCARDTOSOP {
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: '/APL02/GIFTCARDVH',
      element: 'Giftcardnumber'
    }
  }]
  @EndUserText.label: 'Gift Card'
  Giftcardnumber : /apl02/giftcardnumber;
}
