import 'package:erni_eats_fe/data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DonateRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _title = 'Kúpte nám kávu';
    List<Iban> ibans = [
      Iban(name: 'Toma', iban: 'SK36 1100 0000 0029 3106 7480'),
      Iban(name: 'Peto', iban: 'yyy'),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(ibans.length, (index) {
            return TextToCopy(
                label: ibans[index].name, textToCopy: ibans[index].iban);
          }),
        ),
      ),
    );
  }
}

class TextToCopy extends StatelessWidget {
  String label = '';
  String textToCopy = '';

  TextToCopy({required this.label, required this.textToCopy});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            GestureDetector(
              child: IconButton(
                icon: Icon(Icons.copy),
                onPressed: () =>
                    Clipboard.setData(ClipboardData(text: textToCopy)),
              ),
            ),
            Text(textToCopy),
          ],
        ),
      ],
    );
  }
}
