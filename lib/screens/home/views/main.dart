import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/view.dart' as base;

import '../bloc.dart';

class ViewState extends base.ViewState {
  @override
  Widget content(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Text(
            context.strings.homeDescriptionTitle,
            style: context.texts.displaySmall,
          ),
          const SizedBox(height: 40),
          Text(
            context.strings.homeDescriptionBody,
            style: context.texts.bodyMedium,
          ),
          const SizedBox(height: 40),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/hint_1");
                },
                child: Text(context.strings.homeHint1ButtonLabel),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(
                    context,
                    "/hint_2",
                    // arguments: {"key": await context.bloc.serverKey},
                  );
                },
                child: Text(context.strings.homeHint2ButtonLabel),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(context.strings.homeExamButtonLabel),
              )
            ],
          ),
        ],
      ),
    );
  }
}
