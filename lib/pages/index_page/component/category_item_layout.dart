import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItemDefaultLayout extends StatelessWidget {
  final int index;
  final String name;
  final TextStyle textStyle;
  final TextStyle currentStyle;
  final int current;

  const CategoryItemDefaultLayout({this.index, this.name, this.textStyle, Key key, this.current, this.currentStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 50.w, left: index == 0 ? 25.w : 0),
      padding: EdgeInsets.symmetric(horizontal: 25.w),
      child:index==current ? Text(
        name,
        style: currentStyle ?? TextStyle(fontSize: 55.sp, color: Colors.redAccent),
      ) :  Text(
        name,
        style: textStyle ?? TextStyle(fontSize: 55.sp, color: Color.fromRGBO(255, 255, 255, .65)),
      ),
    );
  }
}
