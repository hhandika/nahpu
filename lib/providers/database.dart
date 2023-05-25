import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/services/database/database.dart';

final databaseProvider = Provider<Database>((ref) {
  final db = Database();
  ref.onDispose(db.close);
  return db;
});
