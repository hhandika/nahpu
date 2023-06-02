import 'package:flutter/material.dart';

class PageNavigation {
  PageNavigation({
    required this.currentPage,
    required this.pageCounts,
    required this.isLastPage,
    required this.isFirstPage,
    required this.pageController,
  });
  int currentPage;
  int pageCounts;
  bool isLastPage;
  bool isFirstPage;
  PageController pageController;

  factory PageNavigation.init() {
    return PageNavigation(
      currentPage: 0,
      pageCounts: 0,
      isLastPage: false,
      isFirstPage: false,
      pageController: PageController(),
    );
  }

  void updatePageNavigation() {
    if (currentPage == 1) {
      isFirstPage = true;
      isLastPage = false;
    } else if (currentPage == pageCounts) {
      isFirstPage = false;
      isLastPage = true;
    } else {
      isFirstPage = false;
      isLastPage = false;
    }
  }

  void updatePageController() {
    pageController = PageController(
      initialPage: pageCounts + 1,
      keepPage: false,
    );
  }

  void dispose() {
    pageController.dispose();
  }
}
