import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../modals/dtkCategorys.dart';

class LeftWidgetItem extends StatelessWidget {
  final CategoryItem item;
  final bool isCurrent;

  LeftWidgetItem({this.item, this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(150),
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: isCurrent ? Colors.white : Color.fromRGBO(248, 248, 248, 1.0)),
      child: Text(
        item.cname,
        style: TextStyle(color: isCurrent ? Colors.pinkAccent : Colors.black),
      ),
    );
  }
}
