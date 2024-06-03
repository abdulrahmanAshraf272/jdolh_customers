double roundTwoDecimal(double number) {
  number = (number * 100).roundToDouble() / 100;
  //String formattedDouble = number.toStringAsFixed(2);
  return number;
}
