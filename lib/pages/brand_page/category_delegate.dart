import 'package:demo1/pages/index_page/component/category_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDelegate extends SliverPersistentHeaderDelegate {
  final SelectWithItem onSelect;
  final CategoryController controller;
  CategoryDelegate(this.onSelect, this.controller);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        height: 150.h,
        color: Colors.white,
        alignment: Alignment.center,
        child: CategoryComponent(
          onSelect: onSelect,
          controller: controller,
          textStyle: TextStyle(fontSize: 55.sp, color: Colors.black),
        ));
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 150.h;

  @override
  // TODO: implement minExtent
  double get minExtent => 150.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
