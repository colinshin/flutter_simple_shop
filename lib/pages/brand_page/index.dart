import 'package:after_layout/after_layout.dart';
import 'package:demo1/pages/brand_page/components/item.dart';
import 'package:demo1/pages/brand_page/provider/brand_provider.dart';
import 'package:demo1/pages/index_page/component/category_component.dart';
import 'package:demo1/pages/index_page/model/category_model.dart';
import 'package:demo1/provider/index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'category_delegate.dart';

/// 品牌列表页面
class BrandListPage extends StatefulWidget {
  @override
  _BrandListPageState createState() => _BrandListPageState();
}

class _BrandListPageState extends State<BrandListPage> with AfterLayoutMixin<BrandListPage> {
  CategoryController _categoryController = CategoryController();
  EasyRefreshController _easyRefreshController = EasyRefreshController();
  BrandProvider _brandProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (this._brandProvider == null) this._brandProvider = Provider.of<BrandProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("品牌特卖")),
      body: EasyRefresh.custom(
        controller: _easyRefreshController,
        header: MaterialHeader(),
        footer: MaterialFooter(),
        slivers: [
          SliverPersistentHeader(delegate: CategoryDelegate(_categoryOnSelect, _categoryController),floating: true,),
          SliverWaterfallFlow.count(crossAxisCount: 1, children: _items())
        ],
        onRefresh: _refresh,
        onLoad: _load,
      ),
    );
  }

  List<Widget> _items() => _brandProvider.lists
      .map((e) => BrandItemCard(
            storeInfo: e,
          ))
      .toList();

  /// 刷新页面
  Future<void> _refresh() async {
    await _brandProvider.refresh();
    _easyRefreshController.finishRefresh();
  }

  /// 加载下一页
  Future<void> _load() async {
    await _brandProvider.load();
    _easyRefreshController.finishLoad();
  }

  /// 菜单被选择
  void _categoryOnSelect(int index, MainCategory item) async {
    _categoryController.toIndex(index);
    _brandProvider.setCid("${item.cid}");
    _easyRefreshController.callRefresh();
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    int cid = Provider.of<IndexProvider>(context, listen: false).mainCategorys[0].cid; // 默认获取下标0的分类
    _brandProvider.setCid("$cid");
    await _refresh();
  }
}
