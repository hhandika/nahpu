import 'package:nahpu/services/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

@Riverpod(keepAlive: true)
Database database(DatabaseRef ref) {
  final db = Database();
  ref.onDispose(() {
    db.close();
  });
  return db;
}
