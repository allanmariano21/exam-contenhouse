import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Extension on BuildContext {
  Map<String, dynamic>? get arguments {
    var arg = ModalRoute.of(this)?.settings.arguments;
    return arg == null ? null : arg as Map<String, dynamic>;
  }

  TextTheme get texts => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;

  AppLocalizations? get strings => AppLocalizations.of(this);

  Future<Map<String, dynamic>?> loadJson(
    BuildContext context,
    String path,
  ) async {
    if (!context.mounted) return null;
    final data = await DefaultAssetBundle.of(context).loadString(path);
    return jsonDecode(data);
  }
}
