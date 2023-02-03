import 'package:nahpu/models/navigation.dart';

PageNavigation updatePageNavigation(PageNavigation pageState) {
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

  return pageState;
}
