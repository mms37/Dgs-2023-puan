// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:untitled28/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DGS Puan Hesaplama Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify the initial state of the app
    expect(find.text('DGS Puanı Hesaplama Aracı'), findsOneWidget);
    expect(find.text('Sınav Yılı'), findsOneWidget);
    expect(find.text('* Sınav Sistemi:'), findsOneWidget);
    expect(find.text('Doğru / Yanlış'), findsOneWidget);
    expect(find.text('Sayısal Testi:'), findsOneWidget);
    expect(find.text('Sözel Testi:'), findsOneWidget);
    expect(find.text('Önceki DGS Sonucu'), findsOneWidget);
    expect(find.text('Hesapla'), findsOneWidget);
    expect(find.text('Temizle'), findsOneWidget);

    // Perform the calculations
    await tester.enterText(find.byKey(Key('dgssayisaldogru')), '30');
    await tester.enterText(find.byKey(Key('dgssayisalyanlis')), '10');
    await tester.enterText(find.byKey(Key('dgssozeldogru')), '35');
    await tester.enterText(find.byKey(Key('dgssozelyanlis')), '5');
    await tester.enterText(find.byKey(Key('dgsobp')), '65.25');

    await tester.tap(find.text('Hesapla'));
    await tester.pumpAndSettle();

    // Check the results
    expect(find.text('Eşit Ağırlık için DGS Puanı:'), findsOneWidget);
    expect(find.text('Sayısal için DGS Puanı:'), findsOneWidget);
    expect(find.text('Sözel için DGS Puanı:'), findsOneWidget);

    // Reset the form
    await tester.tap(find.text('Temizle'));
    await tester.pumpAndSettle();

    // Verify the form is reset
    expect(find.text('Eşit Ağırlık için DGS Puanı:'), findsNothing);
    expect(find.text('Sayısal için DGS Puanı:'), findsNothing);
    expect(find.text('Sözel için DGS Puanı:'), findsNothing);
  });
}
