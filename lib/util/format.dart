import 'package:intl/intl.dart';

class FMT {
  static final amountFormatter = NumberFormat("#,##0.00");

  static String amount(double? d) {
    if (d == null) return "--";
    return '\$ ${amountFormatter.format(d)}';
  }
}
