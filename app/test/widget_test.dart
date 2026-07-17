import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wear_my_india/main.dart';

void main() {
  testWidgets('opens the Virasat commission studio', (tester) async {
    await tester.pumpWidget(const WearMyIndiaApp());

    expect(find.text('A saree that begins with you.'), findsOneWidget);
    expect(find.text('BEGIN YOUR COMMISSION'), findsOneWidget);

    await tester.tap(find.text('BEGIN'));
    await tester.pumpAndSettle();

    expect(find.text('Begin with the cloth.'), findsOneWidget);
    expect(find.text('Pure Katan silk'), findsOneWidget);
    expect(find.text('Kora silk'), findsOneWidget);
  });

  testWidgets('commission studio adapts to a phone viewport', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const WearMyIndiaApp());
    await tester.tap(find.text('BEGIN'));
    await tester.pumpAndSettle();

    expect(find.text('LIVE TEXTILE STUDY'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('pattern and colour are visual design stages', (tester) async {
    tester.view.physicalSize = const Size(1440, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const WearMyIndiaApp());
    await tester.tap(find.text('BEGIN'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pattern'));
    await tester.pumpAndSettle();
    expect(find.text('Draw its woven language.'), findsOneWidget);
    expect(find.text('MOTIF SCALE'), findsOneWidget);
    expect(find.text('PATTERN DENSITY'), findsOneWidget);

    await tester.tap(find.text('Colour atelier'));
    await tester.pumpAndSettle();
    expect(find.text('Colour every thread layer.'), findsOneWidget);
    expect(find.text('Body ground'), findsWidgets);
    expect(find.text('Primary motif'), findsOneWidget);
    expect(find.text('GRADIENT'), findsOneWidget);
  });
}
