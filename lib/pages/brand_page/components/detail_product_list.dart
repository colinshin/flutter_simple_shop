import 'package:demo1/pages/brand_page/models/brand_detail_model.dart';
import 'package:demo1/pages/index_page/store/price_layout.dart';
import 'package:demo1/util/image_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

/// 品牌的商品列表
class DetailProductList extends StatelessWidget {
  final List<BrandDetailGoodsList> list;

  const DetailProductList({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate:
            SliverChildBuilderDelegate(_builderList, childCount: list.length));
  }

  Widget _builderList(BuildContext context, int index) {
    BrandDetailGoodsList brandDetailGoodsList = list[index];
    return Card(
      elevation: 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            _buildImage(brandDetailGoodsList),
            SizedBox(width: 40.w,),
            Expanded(child: _buildData(brandDetailGoodsList))
          ],
        ),
      ),
    );
  }

  Widget _buildData(BrandDetailGoodsList item) {
    return SizedBox(
      height: 400.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.dTitle,
            style: TextStyle(
                color: Colors.black,
                fontSize: 50.sp,
                fontWeight: FontWeight.bold),
          ),
          Column(
            children: [PriceLayout(original: item.actualPrice.toString(), discounts: item.originPrice.toString(),)],
          )
        ],
      ),
    );
  }

  // 商品主图
  Widget _buildImage(BrandDetailGoodsList item) {
    Size imageSize = Size(400.w, 400.w);
    return Container(
        color: Colors.grey[200],
        child: Image.network(
          MImageUtils.magesProcessor(item.mainPic),
          width: imageSize.width,
          height: imageSize.height,
        ));
  }
}
