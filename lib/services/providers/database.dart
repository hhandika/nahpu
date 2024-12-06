import 'package:nahpu/services/database/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@Riverpod(keepAlive: true)
Database database(Ref ref) {
  final db = Database();
  ref.onDispose(() {
    db.close();
  });
  return db;
}
