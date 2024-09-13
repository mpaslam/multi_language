import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_language/local_bloc.dart';
import 'package:multi_language/page_1.dart';
import 'package:multi_language/page_2.dart';
import 'app_localization.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocaleBloc(),
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale, // Use locale from BLoC state
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('es', 'ES'),
              Locale('ar', 'SA'), // Added Arabic locale support
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              if (locale != null) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
              }
              return supportedLocales.first;
            },
            home: const HomeScreen(),
            routes: {
              '/page1': (context) => const Page1(),
              '/page2': (context) => const Page2(),
            },
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.read<LocaleBloc>().state.locale;

    // Set image based on the selected language
    String imagePath;
    if (currentLocale.languageCode == 'es') {
      imagePath = 'assest/batman.webp'; // Arabic image
    } else {
      imagePath = 'assest/spider.webp'; // English image
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('welcome') ?? 'Welcome'),
        actions: [
          const LanguageSwitcher(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath), // Display the image
            Text(AppLocalizations.of(context)!.translate('hello') ?? 'Hello'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/page1'),
              child: Text(AppLocalizations.of(context)!.translate('go_to_page1') ?? 'Go to Page 1'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/page2'),
              child: Text(AppLocalizations.of(context)!.translate('go_to_page2') ?? 'Go to Page 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      onSelected: (Locale newLocale) {
        context.read<LocaleBloc>().add(ChangeLocale(newLocale));
      },
      icon: const Icon(Icons.language, color: Colors.white),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        const PopupMenuItem<Locale>(
          value: Locale('en', 'US'),
          child: Text("English"),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('es', 'ES'),
          child: Text("Español"),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('ar', 'SA'),
          child: Text("العربية"), // Arabic
        ),
      ],
    );
  }
}
