import 'dart:convert';

import 'package:demo1/modals/params_model/store_detail_params_model.dart';
import 'package:demo1/modals/params_model/store_params_model.dart';
import 'package:demo1/network/apis.dart';
import 'package:demo1/network/http_request.dart';
import 'package:demo1/pages/brand_page/models/brand_detail_model.dart';
import 'package:demo1/pages/index_page/model/category_model.dart';
import 'package:demo1/pages/index_page/model/store_list_model.dart';
import 'package:demo1/pages/index_page/model/topic_model.dart';

/// 首页服务中心
class IndexService {
  /// 获取超级分类菜单
  static Future<List<MainCategory>> fetchCategory() async {
    String response = await HttpRequest.req(Apis.CATEGORYS);
    if (response.isNotEmpty) return mainCategoryFromJson(response);
    return [];
  }

  /// 获取精选专辑
  static Future<List<MainTopic>> fetchTopics() async {
    String response = await HttpRequest.req(Apis.TOPIC_LIST);
    if (response.isNotEmpty) return mainTopicFromJson(response);
    return [];
  }

  /// 获取品牌栏目列表
  static Future<StoreData> fetchStores(StoreListParamsModel params) async {
    String response = await HttpRequest.req(Apis.BRAND_LIST,
        data: {"cid": params.cid, "pageId": params.pageId, "pageSize": params.pageSize});
    if (response.isNotEmpty) return StoreData.fromJson(json.decode(response));
    return null;
  }

  /// 获取品牌详情
  static Future<BrandDetailModel> fetchStoreDetail(StoreDetailParamsModel params) async {
    String response = await HttpRequest.req(Apis.BRAND_DETAIL,data: {"brandId":params.brandId,"pageId":params.pageId,"pageSize":params.pageSize});
    if(response.isNotEmpty) return BrandDetailModel.fromJson(json.decode(response));
    return null;
  }
}
