import 'package:nahpu/database/database.dart';

class Bloc {
  final Database db;

  Bloc() : db = Database();

  void createProject(ProjectCompanion name) {
    db.createProject(name);
  }

  void close() {
    db.close();
  }
}
