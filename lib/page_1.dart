import 'package:flutter/material.dart';
import 'app_localization.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('page1') ?? 'Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.translate('page1_text') ?? 'This is Page 1'),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.translate('back') ?? 'Back'),
            ),
          ],
        ),
      ),
    );
  }
}
