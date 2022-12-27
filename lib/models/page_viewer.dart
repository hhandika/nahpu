import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/catalogs.dart';

class PageNavigation {
  int currentPage = 0;
  int pageCounts = 0;
  bool isLastPage = false;
  bool isFirstPage = false;
}

void checkPageNavigation(WidgetRef ref) {
  final pageState = ref.watch(pageNavigationProvider);
  if (pageState.currentPage == 1) {
    pageState.isFirstPage = true;
    pageState.isLastPage = false;
  } else if (pageState.currentPage == pageState.pageCounts) {
    pageState.isFirstPage = false;
    pageState.isLastPage = true;
  } else {
    pageState.isFirstPage = false;
    pageState.isLastPage = false;
  }
}
