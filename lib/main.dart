import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:mobile_exam/core/extensions/common.dart';
import 'package:mobile_exam/core/app/routes.dart';
import 'package:mobile_exam/core/services/server.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Screens>(create: (_) => Screens()),
        Provider<Server>(create: (_) => Server()),
      ],
      builder: (context, _) {
        return MaterialApp(
          // app title
          onGenerateTitle: (context) => context.strings.appTitle,

          // backgrounding
          restorationScopeId: 'app', // restore Navigator for backgrounding

          // localization and language
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // route controls
          routes: context.screens,

          builder: (context, child) {
            return ScrollConfiguration(
              behavior: const _ScrollBehavior(),
              child: child ?? Container(),
            );
          },
        );
      },
    );
  }
}

class _ScrollBehavior extends ScrollBehavior {
  const _ScrollBehavior();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
