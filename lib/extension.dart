import 'package:intl/intl.dart';

final _currencyFormatter = NumberFormat.simpleCurrency(
  locale: 'vi',
  decimalDigits: 0,
);

extension Currency on double {
  String formatCurrency() => _currencyFormatter.format(this);
}
