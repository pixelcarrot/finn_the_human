import 'package:finance/model/transaction.dart';

class FinanceRepository {
  final List<Transaction> _mock = [
    Transaction("1", DateTime(2021, 5, 21), 5000000, "SSI", []),
    Transaction("1", DateTime(2021, 6, 23), 2000000, "SSI", []),
    Transaction("3", DateTime(2021, 7, 23), 500000, "SSI", []),
    Transaction("4", DateTime(2021, 8, 28), 1000000, "Binance", []),
    Transaction("5", DateTime(2021, 9, 1), 5000000, "DCVFM", ["DSDC"]),
  ];

  Future<Transaction> getDetails(String id) {
    try {
      return Future.value(_mock.firstWhere((element) => element.id == id));
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<List<Transaction>> getHistory() {
    try {
      _mock.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      return Future.value(_mock);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future addRecord(
    DateTime dateTime,
    double amount,
    String name,
    List<String> tags,
  ) {
    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      _mock.add(Transaction(id, dateTime, amount, name, tags));
      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }
}
