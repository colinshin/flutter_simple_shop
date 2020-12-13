import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 价钱布局
class PriceLayout extends StatelessWidget {

  final String original;// 原价
  final String discounts;// 优惠价
  const PriceLayout({Key key,@required this.original, @required this.discounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 5.h),
      child: Row(
        children: [
          Text("¥ $original",style: TextStyle(fontSize: 52.sp,color: Colors.red)),
          SizedBox(width: 10.w),
          Text("¥$discounts",style: TextStyle(fontSize: 48.sp,color: Colors.grey,decoration: TextDecoration.lineThrough)),
        ],
      ),
    );
  }
}
