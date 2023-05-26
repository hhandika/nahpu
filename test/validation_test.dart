// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/services/types/types.dart';
import 'package:nahpu/services/utility_services.dart';

void main() {
  test('Test project name is valid', () {
    String validProjectName = 'Project Name';
    String invalidProjectName = 'Project Name!?*';
    expect(validProjectName.isValidProjectName, isTrue);
    expect(invalidProjectName.isValidProjectName, isFalse);
  });
  test('Test email is valid', () {
    String validEmail = 'test@gmail.com';
    String invalidEmail = 'test\$\$#%@gmail';
    String validEmailSubdomain = 'test@email.co.id';
    String validEmailSubdomain2 = 'test@email.univ.co.id';
    expect(validEmail.isValidEmail, isTrue);
    expect(invalidEmail.isValidEmail, isFalse);
    expect(validEmailSubdomain.isValidEmail, isTrue);
    expect(validEmailSubdomain2.isValidEmail, isTrue);
  });

  test('Test validation for name', () {
    String name = 'Heru Handika';
    String name2 = 'Bruná Encantada';
    String name3 = 'Name 123';
    String name4 = 'Name J. Be-fore';
    expect(name.isValidName, isTrue);
    expect(name2.isValidName, isTrue);
    expect(name3.isValidName, isFalse);
    expect(name4.isValidName, isTrue);
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

  test('Test Specimen Sex Index', () {
    expect(SpecimenSex.values[0], SpecimenSex.male);
    expect(SpecimenSex.values[1], SpecimenSex.female);
    expect(SpecimenSex.values[2], SpecimenSex.unknown);
    expect(specimenSexList.indexOf('Male'), 0);
    expect(specimenSexList.indexOf('Female'), 1);
    expect(specimenSexList.indexOf('Unknown'), 2);
  });
}
