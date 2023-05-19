import 'package:flutter/material.dart';
import 'package:nahpu/services/types/navigation.dart';

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

PageController updatePageCtr(int size) {
  return PageController(initialPage: size + 1, keepPage: false);
}
