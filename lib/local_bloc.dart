import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocaleEvent {}

class ChangeLocale extends LocaleEvent {
  final Locale locale;
  ChangeLocale(this.locale);
}

class LocaleState {
  final Locale locale;
  LocaleState(this.locale);
}

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState(Locale('en', 'US'))) {
    _loadLocale();
    on<ChangeLocale>((event, emit) async {
      emit(LocaleState(event.locale));
      await _saveLocale(event.locale);
    });
  }

  // Load saved locale from SharedPreferences
  Future<void> _loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('languageCode');
    String? countryCode = prefs.getString('countryCode');

    if (languageCode != null && countryCode != null) {
      add(ChangeLocale(Locale(languageCode, countryCode)));
    }
  }

  // Save locale to SharedPreferences
  Future<void> _saveLocale(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', locale.languageCode);
    await prefs.setString('countryCode', locale.countryCode ?? '');
  }
}
