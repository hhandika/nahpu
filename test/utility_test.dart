import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/services/utility_services.dart';

void main() {
  test('Test list is distinct', () {
    List<String> list = ['a', 'b', 'c', 'a', 'b', 'c'];
    List<String> distinctList = getDistinctList(list);
    expect(distinctList.length, 3);
  });

  test('Test list contains', () {
    List<String> list = [
      'a',
      'b',
      'c',
    ];
    expect(isListContains(list, 'A'), isTrue);
    expect(isListContains(list, 'e'), isFalse);
  });

  test('String contains', () {
    String string = 'abc';
    expect(string.isContain('a'), isTrue);
    expect(string.isContain('A'), isTrue);
    expect(string.isContain('e'), isFalse);
  });

  test('String match', () {
    String string = 'abc';
    String exactString = 'abc';
    expect(string.isMatch('ABC'), isTrue);
    expect(string.isMatchExact(exactString), isTrue);
  });
}
