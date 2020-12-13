import 'package:after_layout/after_layout.dart';
import 'package:demo1/pages/brand_page/provider/brand_provider.dart';
import 'package:demo1/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';

import 'components/detail_brand_info.dart';
import 'components/detail_product_list.dart';

class BrandDetailPage extends StatefulWidget {
  final String brandId;

  const BrandDetailPage({Key key, @required this.brandId}) : super(key: key);

  @override
  _BrandDetailPageState createState() => _BrandDetailPageState();
}

class _BrandDetailPageState extends State<BrandDetailPage>
    with AfterLayoutMixin<BrandDetailPage> {
  BrandProvider _brandProvider;
  EasyRefreshController _easyRefreshController = EasyRefreshController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._brandProvider ??= Provider.of<BrandProvider>(context);
  }

  Widget _buildBody() {
    if (_brandProvider.brandDetailModel == null) return LoadingWidget();
    return EasyRefresh.custom(slivers: [
      SliverToBoxAdapter(
        child: BrandDetail(
            brandDetailModel: _brandProvider.brandDetailModel,
            bgColor: _brandProvider.detailBgColor),
      ),
      DetailProductList(list: _brandProvider.brandGoodsList,)
    ],controller: _easyRefreshController,onLoad: load,);
  }

  // 下一页列表
  Future<void> load()async{
    _easyRefreshController.callLoad();
    bool hasNextPage = await _brandProvider.detailNextPage();
    _easyRefreshController.finishLoad(noMore: !hasNextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("品牌详情")),
      body: _buildBody(),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    await _brandProvider.detail(widget.brandId);
  }

  @override
  void dispose() {
    _brandProvider.emptyDetail();
    super.dispose();
  }
}
