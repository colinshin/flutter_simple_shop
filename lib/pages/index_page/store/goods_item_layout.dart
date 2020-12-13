import 'package:demo1/pages/index_page/model/store_list_model.dart';
import 'package:demo1/util/image_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo1/pages/index_page/store/price_layout.dart';
import 'package:flutter/material.dart';

/// 商品卡片布局
class StoreGoodsItemLayout extends StatelessWidget {
  final StoreGoods storeGoods;

  const StoreGoodsItemLayout({Key key, @required this.storeGoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100].withOpacity(.8),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Image.network(MImageUtils.magesProcessor(storeGoods.mainPic)),
              Positioned(
                child: _buildDiscountLayout(),
                bottom: 0,
                right: 0,
              )
            ],
          ),
          PriceLayout(original: "${storeGoods.actualPrice}", discounts: "${storeGoods.originPrice}")
        ],
      ),
    );
  }

  /// 折扣小部件
  Widget _buildDiscountLayout() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.pinkAccent.withOpacity(.5),
        borderRadius: BorderRadius.all(Radius.circular(30.sp)),
      ),
      child: Text(
        "${storeGoods.discount}折",
        style: TextStyle(fontSize: 50.sp, color: Colors.white),
      ),
    );
  }
}
