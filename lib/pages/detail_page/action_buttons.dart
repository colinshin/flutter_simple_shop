import 'package:demo1/constant/color.dart';
import 'package:demo1/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fsuper/fsuper.dart';
import '../../provider/goods_detail_provider.dart';

// 底部浮动操作按钮
class ActionButtons extends StatelessWidget {
  final String goodsId;
  final Function getCallBack;
  final GoodsDetailProvider goodsDetailProvider;
  final UserProvider userProvider;

  ActionButtons(
      {this.goodsId,
      this.getCallBack,
      this.goodsDetailProvider,
      this.userProvider});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: ScreenUtil().setHeight(50),
      left: ScreenUtil().setWidth(70),
      child: FSuper(
        width: ScreenUtil().setWidth(1300),
        height: ScreenUtil().setHeight(240),
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.85),
        shadowColor: Colors.black26,
        shadowBlur: 10,
        child2: Row(
          children: <Widget>[
            Container(
              width: ScreenUtil().setWidth(600),
              height: ScreenUtil().setHeight(200),
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(20),
                  vertical: ScreenUtil().setHeight(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FSuper(
                    height: ScreenUtil().setHeight(250),
//                    width: ScreenUtil().setWidth(180),
                    text: "首页",
                    textAlignment: Alignment.bottomCenter,
                    child1Alignment: Alignment.topCenter,
                    child1: Icon(
                      Icons.home,
                      size: ScreenUtil().setSp(70),
                    ),
                  ),
                  FSuper(
                    height: ScreenUtil().setHeight(250),
//                    width: ScreenUtil().setWidth(180),
                    text: "分享",
                    textAlignment: Alignment.bottomCenter,
                    child1Alignment: Alignment.topCenter,
                    child1: Icon(
                      Icons.share,
                      size: ScreenUtil().setSp(70),
                    ),
                  ),
                  goodsDetailProvider.isHaveFav == 0
                      ? InkWell(
                          onTap: () async {
                            // 添加收藏
                            await goodsDetailProvider.addGoodsFavoriteFun();
                            // 刷新收藏列表
                            userProvider.resetFavoriteData();
                            await userProvider.loadUserFavoriteGoodsListFun(1);
                          },
                          child: FSuper(
                            height: ScreenUtil().setHeight(250),
//                    width: ScreenUtil().setWidth(180),
                            text: "收藏",
                            textAlignment: Alignment.bottomCenter,
                            child1Alignment: Alignment.topCenter,
                            child1: Icon(
                              Icons.favorite_border,
                              size: ScreenUtil().setSp(70),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            await goodsDetailProvider.removeGoodsFavoriteFun();
                            userProvider.resetFavoriteData();
                            await userProvider.loadUserFavoriteGoodsListFun(1);
                          },
                          child: FSuper(
                            height: ScreenUtil().setHeight(250),
//                    width: ScreenUtil().setWidth(180),
                            text: "收藏",
                            textAlignment: Alignment.bottomCenter,
                            child1Alignment: Alignment.topCenter,
                            child1: Icon(
                              Icons.favorite,
                              size: ScreenUtil().setSp(70),
                              color: primaryColor,
                            ),
                          ),
                        )
                ],
              ),
            ),
            FSuper(
              width: ScreenUtil().setWidth(620),
              height: ScreenUtil().setHeight(250),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              gradient: LinearGradient(colors: [
                Color(0xfff093fb),
                Color(0xfff5576c),
              ]),
              child2: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Text(
                      "复制口令",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                      height: ScreenUtil().setHeight(40),
                      child: VerticalDivider(color: Colors.white)),
                  InkWell(
                    onTap: getCallBack,
                    child: Container(
                      child: Text(
                        "领券购买",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
