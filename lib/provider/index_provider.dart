import 'package:demo1/modals/params_model/store_params_model.dart';
import 'package:demo1/pages/index_page/model/category_model.dart';
import 'package:demo1/pages/index_page/model/store_list_model.dart';
import 'package:demo1/pages/index_page/model/topic_model.dart';
import 'package:demo1/service/app_service.dart';
import 'package:demo1/util/color_util.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

/// 首页状态管理
class IndexProvider with ChangeNotifier {
  Color topBackground = Colors.pinkAccent;
  List<MainCategory> mainCategorys = []; // 超级分类数据
  List<MainTopic> mainTopic = []; // 轮播
  StoreData storeData; // 首页显示的品牌
  Map<int,Color> brandBgColorMap = Map(); // 背景颜色

  /// 加载超级分类菜单
  Future<void> fetchCategorys() async {
    List<MainCategory> list = await IndexService.fetchCategory();
    this.mainCategorys = list;
    notifyListeners();
  }

  /// 获取精选专辑列表
  Future<void> fetchTopics() async {
    List<MainTopic> list = await IndexService.fetchTopics();
    this.mainTopic = list;
    notifyListeners();
  }

  /// 获取品牌栏目列表
  Future<void> fetchStores() async {
    StoreData _storeData = await IndexService.fetchStores(StoreListParamsModel(mainCategorys[0].cid.toString(), "1", "10"));
    this.storeData = _storeData;
    this.getBrandBgColors();
    notifyListeners();
  }

  /// 改变顶部背景颜色
  Future<void> changeToColor(String netImageUrl) async {
    this.topBackground =await ColorUtil.getImageMainColor(netImageUrl);
    notifyListeners();
  }

  /// 获取品牌logo的主要背景颜色
  Future<void> getBrandBgColors ()async{
    if(storeData!=null){
      if(storeData.lists.isNotEmpty){
        for(StoreInfo info in storeData.lists){
          Color color = await ColorUtil.getImageMainColor(info.brandLogo);
          brandBgColorMap[info.brandId] = color;
        }
        notifyListeners();
      }
    }
  }
}
