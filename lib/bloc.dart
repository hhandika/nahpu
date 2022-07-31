import 'package:nahpu/database/database.dart';

class Bloc {
  Bloc() : db = Database();

  final Database db;

  void createProject(ProjectCompanion name) {
    db.createProject(name);
  }

  void close() {
    db.close();
  }
}
