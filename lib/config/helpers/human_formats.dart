import 'package:intl/intl.dart';

class HumanFormats {

  static String number(double number) {
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
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