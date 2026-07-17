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

    expect(find.text('What should this saree remember?'), findsOneWidget);
    expect(find.text('Wedding heirloom'), findsOneWidget);
  });

  testWidgets('commission studio adapts to a phone viewport', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const WearMyIndiaApp());
    await tester.tap(find.text('BEGIN'));
    await tester.pumpAndSettle();

    expect(find.text('YOUR VIRASAT'), findsOneWidget);
    expect(find.text('CONTINUE'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
