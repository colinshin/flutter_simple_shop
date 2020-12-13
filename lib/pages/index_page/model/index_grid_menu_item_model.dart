
import 'package:flutter/material.dart';

/// 2020年11月17日 22:41:38
/// 首页网格菜单模型
/// v2.0
class IndexGridMenuItemModel {
  String title; // 标题
  String iconUrl;// icon 网络地址
  IndexGridMenuItemModelClickModel clickType; // 响应事件类型
  Map<String,String> params;
  Widget widget; // 跳转到的页面

  IndexGridMenuItemModel(
      this.title, this.iconUrl, this.clickType, {this.params,this.widget}); // 参数

}

/// 点击事件响应类型
enum IndexGridMenuItemModelClickModel {
  BROWSER, // 跳转到浏览器
  INNER_VIEW, // 跳转到APP页面内
  TAOBAO, // 跳转到淘宝app
}
