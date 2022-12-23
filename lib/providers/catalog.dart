import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/types.dart';
import 'package:nahpu/providers/settings.dart';

final catalogFmtProvider =
    StateNotifierProvider<CatalogFmtNotifier, CatalogFmt>(
        (ref) => CatalogFmtNotifier());

class CatalogFmtNotifier extends StateNotifier<CatalogFmt> {
  CatalogFmtNotifier() : super(CatalogFmt.generalMammals);

  void setCatalogFmt(CatalogFmt catalogFmt) {
    state = catalogFmt;
  }
}

// We need to save the catalog number to the shared preferences
// so that we can retrieve it when the app is restarted.
// and also we can use it to generate the catalog number for the
// next project.
final catalogNumberProvider =
    StateNotifierProvider<CatalogNumberNotifier, int>((ref) {
  return CatalogNumberNotifier();
});

class CatalogNumberNotifier extends StateNotifier<int> {
  CatalogNumberNotifier() : super(0);

  void initCatNum(WidgetRef ref) {
    final prefs = ref.read(settingProvider);
    final lastCatNum = prefs.getInt('catNum');
    if (lastCatNum != null) {
      state = lastCatNum;
    }
  }

  void increaseCatNum() {
    state++;
  }

  void decreaseCatNum() {
    state--;
  }

  void saveCatNum(WidgetRef ref) {
    final prefs = ref.read(settingProvider);
    prefs.setInt('catNum', state);
  }
}
