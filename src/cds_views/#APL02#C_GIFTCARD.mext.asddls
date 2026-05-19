@Metadata.layer: #CORE
@UI: {
  headerInfo: {
    typeName: 'Gift Card Details',
    typeNamePlural: 'Gift Card Details',
    title: { type: #STANDARD, value: 'Giftcardnumber' },
    description: { type: #STANDARD, value: 'SapDescription' }
  }
}
@Search.searchable: true
annotate view /APL02/C_GIFTCARD with
{
  @UI.facet: [ {
    id: 'idIdentification',
    type: #IDENTIFICATION_REFERENCE,
    label: 'Gift Card',
    position: 10
  } ]

  @UI.hidden: true
  SapUUID;

  @UI.lineItem: [ {
    position: 10,
    importance: #MEDIUM,
    label: 'Gift Card Number'
  } ]
  @UI.identification: [ {
    position: 10,
    label: 'Gift Card Number'
  } ]
  @UI.selectionField: [{ position: 10 }]
  @Search.defaultSearchElement: true
  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: '/APL02/GIFTCARDVH',
      element: 'Giftcardnumber'
    }
  } ]
  Giftcardnumber;

  @UI.lineItem: [ {
    position: 20,
    importance: #MEDIUM,
    label: 'Description'
  } ]
  @UI.identification: [ {
    position: 20,
    label: 'Description'
  } ]
  @Search.defaultSearchElement: true
  SapDescription;

  @UI.lineItem: [ {
    position: 30,
    importance: #MEDIUM,
    label: 'Gift Card Amount'
  } ]
  @UI.identification: [ {
    position: 30,
    label: 'Gift Card Amount'
  } ]
  @Search.defaultSearchElement: true
  AmountV;

  @Consumption.valueHelpDefinition: [ {
    entity: {
      name: 'I_CurrencyStdVH',
      element: 'Currency'
    }
  } ]
  AmountC;

  @UI.hidden: true
  LocalLastChanged;

  @UI.hidden: true
  LastChanged;
}
