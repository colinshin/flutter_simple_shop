import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPublicLayout extends StatelessWidget {
  final Widget child;
  final bool transparencyBg; //是否透明背景
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadius borderRadius;

  IndexPublicLayout(
      {this.child, this.transparencyBg, this.padding, this.margin,this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    if (transparencyBg != null && transparencyBg) {
      return Container(
        decoration: _buildStyle(),
        padding: padding ?? EdgeInsets.only(top: 10.0),
        margin: margin?? EdgeInsets.only(top: 10, left: 50.w, right: 50.w),
        child: child,
      );
    }
    return Container(
      decoration: _buildStyle(),
      padding: padding == null ? EdgeInsets.only(top: 10.0) : EdgeInsets.zero,
      margin: margin == null
          ? EdgeInsets.only(top: 10, left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50))
          : EdgeInsets.zero,
      child: child,
    );
  }

  BoxDecoration _buildStyle() {
    return BoxDecoration(
        color: transparencyBg != null && transparencyBg
            ? Colors.transparent
            : Colors.white,
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(1.0, 2.0), //阴影xy轴偏移量
              blurRadius: 5.0, //阴影模糊程度
              spreadRadius: -1 //阴影扩散程度
              )
        ]);
  }
}
