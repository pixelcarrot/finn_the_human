import 'dart:async';

import 'package:finance/feature/details/viewmodel/details_state.dart';
import 'package:finance/repository/finance_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(DetailsState initialState) : super(initialState);

  final _repository = FinanceRepository(); // TODO: injection
  final _event = StreamController<dynamic>();
  late final Stream<dynamic> event = _event.stream;

  void getDetails(String id) {
    _repository.getDetails(id).then((value) {
      emit(DetailsState(transaction: value));
    }).catchError((exception) {
      _event.add(exception.toString());
    });
  }
}
