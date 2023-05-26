import 'package:nahpu/providers/settings.dart';
import 'package:nahpu/services/collevent_services.dart';
import 'package:nahpu/services/io_services.dart';
import 'package:nahpu/services/specimen_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String newDbPref = 'isNewDb';

class DbServices extends DbAccess {
  DbServices(super.ref);

  SharedPreferences get prefs => ref.read(settingProvider);

  Future<void> setNewDatabase() async {
    await prefs.setBool(newDbPref, true);
  }

  Future<void> syncSettingWithDb() async {
    SpecimenPartServices(ref).getSpecimenTypes();
    SpecimenPartServices(ref).getTreatmentOptions();
    CollEventServices(ref).getAllDistinctRoles();
    _inValidateSettings();
  }

  Future<bool> checkNewDatabase() async {
    final isNewDb = prefs.getBool(newDbPref) ?? false;
    return isNewDb;
  }

  Future<void> _inValidateSettings() async {
    await prefs.setBool(newDbPref, false);
  }
}
