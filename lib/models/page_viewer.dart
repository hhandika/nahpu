import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nahpu/providers/page_viewer.dart';

class PageNavigation {
  int currentPage = 0;
  int pageCounts = 0;
  bool isLastPage = false;
  bool isFirstPage = false;
}

void checkPageNavigation(WidgetRef ref) {
  final pageState = ref.watch(pageNavigationProvider.state).state;
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

class PersonnelInfo {
  String? id;
  String? name;
  String? initial;
  PersonnelInfo({required this.id, required this.name, required this.initial});
}
