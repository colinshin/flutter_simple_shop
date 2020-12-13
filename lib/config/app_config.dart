import 'package:demo1/pages/brand_page/index.dart';
import 'package:demo1/pages/index_page/model/index_carousel_item_model.dart';
import 'package:demo1/pages/index_page/model/index_grid_menu_item_model.dart';

class AppConfig {}

/// 2020年11月17日 23:20:10
/// 首页的网格菜单
/// !!静态数据!!
/// v2.0
final List<IndexGridMenuItemModel> indexGridMenus = [
  IndexGridMenuItemModel(
      "疯抢排行",
      "https://img.alicdn.com/imgextra/i2/2053469401/O1CN01cd4Sbe2JJi0BtsCQ9_!!2053469401.png",
      IndexGridMenuItemModelClickModel.BROWSER,
      params: getToBrowserParams("http://itbug.shop/index.php?r=activity/sc#/fengqianglist")),
  IndexGridMenuItemModel(
      "9.9包邮",
      "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01yAF5em2JJi03dO5Rt_!!2053469401.png",
      IndexGridMenuItemModelClickModel.BROWSER,
      params: getToBrowserParams("http://itbug.shop/index.php?r=activity/sc#/fengqianglist")),
  IndexGridMenuItemModel(
      "品牌特卖",
      "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01Kl54Hm2JJi0M4oJzL_!!2053469401.png",
      IndexGridMenuItemModelClickModel.INNER_VIEW,
      widget: BrandListPage()),
  IndexGridMenuItemModel(
      "每日半价",
      "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01VHkeLW2JJi03dNHba_!!2053469401.png",
      IndexGridMenuItemModelClickModel.BROWSER,
      params: getToBrowserParams("http://itbug.shop/index.php?r=activity/sc#/fengqianglist")),
  IndexGridMenuItemModel(
      "折上折",
      "https://img.alicdn.com/imgextra/i2/2053469401/O1CN01cUcsnS2JJi03dPxrH_!!2053469401.png",
      IndexGridMenuItemModelClickModel.BROWSER,
      params: getToBrowserParams("http://itbug.shop/index.php?r=activity/sc#/fengqianglist")),
];

/// 2020年11月18日09:47:46
/// 首页轮播图的静态数据
/// v2.0
final List<IndexCarouselItemModel> indexCarouselsStateDatas = [
  IndexCarouselItemModel(
      title: "温暖秋冬,最高领50元优惠券",
      imageUrl: "https://img.alicdn.com/imgextra/i2/2053469401/O1CN01zWvohl2JJhz8nII9X_!!2053469401.jpg",
      clickType: "brower",
      params: "",
      intro: "一些备注,介绍"),
  IndexCarouselItemModel(
      title: "9块9爆品集",
      imageUrl: "https://img.alicdn.com/imgextra/i3/2053469401/O1CN01ZAZQnc2JJi3AT22Il_!!2053469401.jpg",
      clickType: "brower",
      params: "",
      intro: "一些备注,介绍"),
  IndexCarouselItemModel(
      title: "为你倾心",
      imageUrl: "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01u4PlHK2JJhzBsGH04_!!2053469401.jpg",
      clickType: "brower",
      params: "",
      intro: "一些备注,介绍"),
  IndexCarouselItemModel(
      title: "休闲零食",
      imageUrl: "https://img.alicdn.com/imgextra/i4/2053469401/O1CN01sZei422JJi3BIqYCi_!!2053469401.jpg",
      clickType: "brower",
      params: "",
      intro: "一些备注,介绍"),
  IndexCarouselItemModel(
      title: "全球尖货",
      imageUrl: "https://img.alicdn.com/imgextra/i1/2053469401/O1CN01oKK8D32JJi3C0Twb4_!!2053469401.jpg",
      clickType: "brower",
      params: "",
      intro: "一些备注,介绍")
];

// 跳转到外部浏览器的参数
Map<String, String> getToBrowserParams(String url) {
  Map<String, String> map = Map<String, String>();
  map["url"] = "$url"; // 跳转url
  return map;
}
