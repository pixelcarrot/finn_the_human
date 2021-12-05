class Transaction {
  String id;
  DateTime dateTime;
  double amount;
  String note;
  List<String> tags;

  Transaction(
    this.id,
    this.dateTime,
    this.amount,
    this.note,
    this.tags,
  );
}
