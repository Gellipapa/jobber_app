import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/main.dart';

extension LocalizationExtensions on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}

extension LocalizationExt on Object {
  AppLocalizations get loc {
    final context = ourNavigatorKey.currentContext!;
    return AppLocalizations.of(context)!;
  }
}
