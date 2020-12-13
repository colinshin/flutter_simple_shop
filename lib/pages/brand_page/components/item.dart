import 'package:demo1/pages/brand_page/provider/brand_provider.dart';
import 'package:demo1/pages/index_page/model/store_list_model.dart';
import 'package:demo1/pages/index_page/store/goods_item_layout.dart';
import 'package:demo1/util/image_util.dart';
import 'package:demo1/util/number_cover.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';

import '../brand_detail.dart';

/// 品牌布局
class BrandItemCard extends StatelessWidget {
  final StoreInfo storeInfo;

  const BrandItemCard({Key key, this.storeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
       routePush(BrandDetailPage(brandId: storeInfo.brandId.toString()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          children: [_buildHeader(), _buildGoodsGrid()],
        ),
      ),
    );
  }

  /// 品牌信息栏目
  Widget _buildHeader() {
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        children: [
          _buildHeaderFlexCore(
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Image.network(
                  MImageUtils.magesProcessor(storeInfo.brandLogo),
                  width: 100.w,
                  height: 150.h,
                ),
              ),
              1),
          _buildHeaderFlexCore(
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${storeInfo.brandName}",
                          style: TextStyle(fontSize: 55.sp, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "已售${Numeral(storeInfo.sales)}件 >",
                          style: TextStyle(fontSize: 48.sp, color: Colors.grey[500]),
                        )
                      ],
                    ),
                    Text(
                      "单品低至${storeInfo.maxDiscount}折  |  领券最高减${storeInfo.maxDiscountAmount}",
                      style: TextStyle(fontSize: 48.sp, color: Colors.redAccent),
                    )
                  ],
                ),
              ),
              5),
        ],
      ),
    );
  }

  /// 产品列表
  Widget _buildGoodsGrid() {
    return GridView.count(
      crossAxisCount: 3,
      children: [
        StoreGoodsItemLayout(storeGoods: storeInfo.goodsList[0]),
        StoreGoodsItemLayout(storeGoods: storeInfo.goodsList[1]),
        StoreGoodsItemLayout(storeGoods: storeInfo.goodsList[2]),
      ],
      childAspectRatio: .8,
      shrinkWrap: true,
      crossAxisSpacing: 30.w,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildHeaderFlexCore(Widget widget, int flex) {
    return Flexible(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(5),
        child: widget,
      ),
      flex: flex,
    );
  }
}
