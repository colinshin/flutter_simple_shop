import 'package:demo1/pages/index_page/model/store_list_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

import 'goods_item_layout.dart';

/// 品牌下方的商品列表
class StoreGoodsCard extends StatelessWidget {
  final StoreInfo storeInfo; // 接收一个品牌参数

  const StoreGoodsCard({Key key, this.storeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.8, mainAxisSpacing: 10.w),
      itemBuilder: (BuildContext context, int index) {
        StoreGoods storeGoods = storeInfo.goodsList[index];
        return StoreGoodsItemLayout(storeGoods: storeGoods);
      },
      itemCount: 3,
    );
  }
}
