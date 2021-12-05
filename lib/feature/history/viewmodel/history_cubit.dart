import 'dart:async';

import 'package:finance/feature/history/viewmodel/history_state.dart';
import 'package:finance/repository/finance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(HistoryState initialState) : super(initialState);

  final _repository = FinanceRepository(); // TODO: injection
  final _event = StreamController<dynamic>();
  late final Stream<dynamic> event = _event.stream;

  void getHistory() {
    _repository.getHistory().then((value) {
      emit(HistoryState(history: value));
    }).catchError((exception) {
      _event.add(exception.toString());
    });
  }

  void addRecord(
    DateTime dateTime,
    double amount,
    String note,
    List<String> tags,
  ) {
    if (note.trim().length < 3) {
      _event.add("Note cannot be empty");
      return;
    }
    _repository.addRecord(dateTime, amount, note, tags).then((_) {
      getHistory();
      _event.add("$amount was added successfully");
    }).catchError((exception) {
      _event.add(exception.toString());
    });
  }
}
