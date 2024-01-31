import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as base;
import 'package:mobile_exam/core/app/view.dart' as view;

import 'bloc.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  Bloc? _bloc;

  @override
  void dispose() {
    _bloc?.close().then((b) => b.dispose());
    _bloc = null; // remove reference
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _bloc ?? (_bloc = Bloc(context)),
      builder: (context, _) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(context.strings.hint2AppbarTitle),
            ),
            body: SafeArea(
              child: base.BlocBuilder<Bloc, view.ViewState>(
                builder: (context, state) => state.view(context),
              ),
            ),
          ),
        );
      },
    );
  }
}
