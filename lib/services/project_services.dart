import 'package:uuid/uuid.dart';
import 'package:nahpu/providers/projects.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

get uuid => const Uuid().v4();

void deleteProject(WidgetRef ref, String uuid) {
  ref.read(databaseProvider).deleteProject(uuid);
  ref.invalidate(projectListProvider);
}
