import 'package:intl/intl.dart';

class HumanFormats {

  static String number(double number, {int decimalDigits = 0}) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en'
    ).format(number);
    return formatterNumber;
  }
  
  static String monthName(int month) {
    final formatter = DateFormat('MMMM', 'es_ES');
    return formatter.format(DateTime(2021, month));
  }

}