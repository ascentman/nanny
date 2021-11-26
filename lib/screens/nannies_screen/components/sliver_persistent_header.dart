import 'package:flutter/material.dart';

class SliverPersistentHeaderWidget extends SliverPersistentHeaderDelegate {
  final Widget widget;

  SliverPersistentHeaderWidget({required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => 40.0;

  @override
  double get minExtent => 40.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
