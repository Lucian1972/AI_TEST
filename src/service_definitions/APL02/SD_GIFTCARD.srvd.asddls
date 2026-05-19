@EndUserText.label: 'Gift Card Service Definition'
define service /APL02/SD_GIFTCARD {
  expose /APL02/C_GIFTCARD   as GiftCard;
  expose /APL02/GIFTCARDVH   as GiftCardVH;
  expose I_CurrencyStdVH   as CurrencyValueHelp;
}
