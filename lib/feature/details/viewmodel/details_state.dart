import 'package:finance/model/transaction.dart';

class DetailsState {
  final Transaction transaction;
  bool isEmpty = false;

  DetailsState({
    required this.transaction,
  });

  static DetailsState empty() {
    var value = DetailsState(
      transaction: Transaction(
        "",
        DateTime.now(),
        0,
        "",
        [],
      ),
    );
    value.isEmpty = true;
    return value;
  }
}
