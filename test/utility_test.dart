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
}
