import 'package:flutter/material.dart';
import 'app_localization.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.translate('page2') ?? 'Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.translate('page2_text') ?? 'This is Page 2'),
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
