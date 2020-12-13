import 'package:demo1/config/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'grid_menu.dart';
import 'model/index_grid_menu_item_model.dart';

/// 2020年11月17日 22:48:26
/// 首页的网格菜单列表
/// v2.0
/// 每排最好只显示5个
/// 不超过两排
/// 控制好数量
class GridMenuList extends StatefulWidget {
  @override
  _GridMenuListState createState() => _GridMenuListState();
}

class _GridMenuListState extends State<GridMenuList> {
  final int rowCount = 5;
  List<IndexGridMenuItemModel> _items;

  @override
  void initState() {
    super.initState();
    _getList();
  }

  void _getList(){
    setState(() {
      _items = indexGridMenus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: rowCount,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: _items
              .map((e) => IndexGridViewMenu(
                    model: e,
                  ))
              .toList()),
    );
  }
}
