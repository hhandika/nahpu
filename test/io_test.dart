import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:nahpu/services/database/database.dart';

void main() {
  test('Test database path', () async {
    File path = await dBPath;
    expect(path.path, contains('nahpu.db'));
  });
}
