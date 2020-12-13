import 'package:demo1/pages/index_page/model/index_grid_menu_item_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

/// 2020年11月17日 22:36:07
/// 首页的网格菜单
/// v2.0
class IndexGridViewMenu extends StatelessWidget {

  final IndexGridMenuItemModel model;

  const IndexGridViewMenu({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        switch(model.clickType){
          case IndexGridMenuItemModelClickModel.INNER_VIEW:
            routePush(model.widget);
            break;
          default:
            break;
        }
      },
      child: Container(
        child: Column(
          children: [
            Expanded(child: Container(
              child: ExtendedImage.network(
                "${model.iconUrl}"
              ),
            )),
            Text("${model.title}",style: TextStyle(fontSize: 50.sp))
          ],
        ),
      ),
    );
  }
}
