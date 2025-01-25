import 'package:flutter/material.dart';
import 'package:monophony/controllers/page_controller.dart';

class CustomVerticalPageView extends StatefulWidget {
  final List<Widget> pages;
  final AppPageController controller;

  const CustomVerticalPageView({
    super.key,
    required this.pages,
    required this.controller,
  });

  @override
  State<CustomVerticalPageView> createState() => _CustomVerticalPageViewState();
}

class _CustomVerticalPageViewState extends State<CustomVerticalPageView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: widget.controller.currentPage);
    widget.controller.registerPageChange(_handlePageChange);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handlePageChange(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 500),
      curve: const Cubic(0.32, 0.72, 0, 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.pages.length,
      itemBuilder: (context, index) {
        return KeepAlivePage(
          child: widget.pages[index],
        );
      },
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  final Widget child;

  const KeepAlivePage({
    super.key,
    required this.child,
  });

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
