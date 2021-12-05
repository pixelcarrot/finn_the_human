import 'dart:async';

import 'package:finance/extension.dart';
import 'package:finance/feature/details/details_page.dart';
import 'package:finance/feature/history/viewmodel/history_cubit.dart';
import 'package:finance/feature/history/viewmodel/history_state.dart';
import 'package:finance/widget/input_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<HistoryPage> createState() => _HistoryPageImpl();
}

class _HistoryPageImpl extends State<HistoryPage> {
  late HistoryCubit _cubit;
  late StreamSubscription _sideEffects;

  @override
  void initState() {
    super.initState();
    // init view model with default value: empty
    _cubit = HistoryCubit(HistoryState.empty());
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
      body: RefreshIndicator(
        onRefresh: () async {
          _cubit.getHistory();
        },
        child: BlocProvider(
          create: (context) => _cubit,
          child: BlocBuilder<HistoryCubit, HistoryState>(
            builder: (context, state) {
              if (state.isEmpty) {
                _cubit.getHistory();
                return _createPlaceholder();
              } else {
                return _createContent(state);
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return InputDialog(
                  title: "Hello world",
                  hint: "Whatever",
                  onOkPressed: (text) {
                    _cubit.addRecord(DateTime.now(), 1000000, text, []);
                    Navigator.pop(context);
                  },
                  onCancelPressed: () {
                    Navigator.pop(context);
                  },
                );
              });
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const DetailsPage(
          //       title: "Add",
          //       id: null,
          //     ),
          //   ),
          // );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _createPlaceholder() {
    return Container(
      child: const Text("Loading..."),
      alignment: Alignment.center,
    );
  }

  Widget _createContent(HistoryState state) {
    return ListView.separated(
      itemCount: state.history.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        final item = state.history[index];
        return ListTile(
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.green,
            ),
            width: 50,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              item.note.substring(0, 2).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          title: Text(item.amount.formatCurrency()),
          subtitle: Text(_formatter.format(item.dateTime)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(
                  title: "Details",
                  id: state.history[index].id,
                ),
              ),
            );
          },
        );
      },
    );
  }

  static final _formatter = DateFormat('yyyy MMM dd');
}
