// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'dart:js_util';

// import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

// import 'package:nahpu/main.dart';
import 'package:nahpu/providers/validation.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });
  test('Test email is valid', () {
    String email = 'test@gmail.com';
    String email2 = 'test\$\$#%@gmail';
    expect(email.isValidEmail, isTrue);
    expect(email2.isValidEmail, isFalse);
  });

  test('Test validation for name', () {
    String name = 'Heru Handika';
    String name2 = 'Bruná Encantada';
    String name3 = 'Name 123';
    expect(name.isValidName, isTrue);
    expect(name2.isValidName, isTrue);
    expect(name3.isValidName, isFalse);
  });

  test('Test validation for project names', () {
    String projectName = 'Project Name';
    String projectName2 = 'Project Name2';
    String projectName3 = 'Project Name!?*';
    expect(projectName.isValidProjectName, isTrue);
    expect(projectName2.isValidProjectName, isTrue);
    expect(projectName3.isValidProjectName, isFalse);
  });

  test('Test valid catalog numbers', (() {
    String catNum = '123456789';
    String catNum2 = '1234567890';
    String catNum3 = '12345678901wrw';
    expect(catNum.isValidCollNum, isTrue);
    expect(catNum2.isValidCollNum, isTrue);
    expect(catNum3.isValidCollNum, isFalse);
  }));
}
