export 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view.dart' as view;

class Bloc extends Cubit<view.ViewState> with ChangeNotifier {
  Bloc(
    view.ViewState initialState, {
    required this.context,
  }) : super(initialState) {
    init();
  }

  final BuildContext context;

  void init() async {}
  void updateView() => notifyListeners();

  @override
  Future<Bloc> close() {
    return super.close().then<Bloc>((value) => this);
  }
}
