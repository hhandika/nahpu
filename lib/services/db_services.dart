import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbServices extends DbAccess {
  DbServices(super.ref);

  SharedPreferences get prefs => ref.read(settingProvider);

  Future<void> setNewDatabase() async {
    await prefs.setBool('isNewDb', true);
  }

  Future<void> syncSettingWithDb() async {
    SpecimenPartServices(ref).getAllDistinctTypes();
    CollEventServices(ref).getAllDistinctRoles();
    _inValidateSettings();
  }

  Future<bool> checkNewDatabase() async {
    final isNewDb = prefs.getBool('isNewDb') ?? false;
    return isNewDb;
  }

  Future<void> _inValidateSettings() async {
    await prefs.setBool('isNewDb', false);
  }
}
