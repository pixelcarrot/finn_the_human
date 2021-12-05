import 'dart:async';

import 'package:finance/extension.dart';
import 'package:finance/feature/details/viewmodel/details_cubit.dart';
import 'package:finance/feature/details/viewmodel/details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  final String title;
  final String? id;

  @override
  State<DetailsPage> createState() => _DetailsPageImpl();
}

class _DetailsPageImpl extends State<DetailsPage> {
  late DetailsCubit _cubit;
  late StreamSubscription _sideEffects;

  @override
  void initState() {
    super.initState();
    // init view model with default value: empty
    _cubit = DetailsCubit(DetailsState.empty());
    _sideEffects = _cubit.event.listen((event) => _onEvent(event));
  }

  @override
  void dispose() {
    _sideEffects.cancel();
    super.dispose();
  }

  // listen to side effects from view model (cubit)
  void _onEvent(event) {
    debugPrint(event.toString());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(event.toString())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocProvider(
        create: (context) => _cubit,
        child: BlocBuilder<DetailsCubit, DetailsState>(
          builder: (context, state) {
            if (widget.id == null) {
              return _createAddContent(state);
            } else if (state.isEmpty) {
              _cubit.getDetails(widget.id!);
              return _createPlaceholder();
            } else {
              return _createEditContent(state);
            }
          },
        ),
      ),
    );
  }

  Widget _createPlaceholder() {
    return Container(
      child: const Text("Loading..."),
      alignment: Alignment.center,
    );
  }

  Widget _createEditContent(DetailsState state) {
    return ListView(
      children: [
        Text(
          state.transaction.amount.formatCurrency(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.green,
          ),
        ),
        Text(
          state.transaction.note,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.black54,
          ),
        )
      ],
    );
  }

  Widget _createAddContent(DetailsState state) {
    return const Text("TODO");
  }
}
