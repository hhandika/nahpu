import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nahpu/models/catalogs.dart';

final catalogFmtProvider =
    StateNotifierProvider<CatalogFmtNotifier, CatalogFmt>(
        (ref) => CatalogFmtNotifier());

class CatalogFmtNotifier extends StateNotifier<CatalogFmt> {
  CatalogFmtNotifier() : super(CatalogFmt.generalMammals);

  void setCatalogFmt(CatalogFmt catalogFmt) {
    state = catalogFmt;
  }
}
