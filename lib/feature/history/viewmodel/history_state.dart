import 'package:finance/model/transaction.dart';

class HistoryState {
  final List<Transaction> history;
  bool isEmpty = false;

  HistoryState({
    required this.history,
  });

  static HistoryState empty() {
    var value = HistoryState(history: []);
    value.isEmpty = true;
    return value;
  }
}
