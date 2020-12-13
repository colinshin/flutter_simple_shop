import 'package:flutter/material.dart';

class SortWidget extends StatelessWidget {

  final dynamic onTap;
  final String title;
  final bool current;
  final Widget icon;

  SortWidget({this.onTap, this.title, this.current,this.icon}); //是否选中状态


  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          icon!=null ? icon : Container()
        ],
      )
    );
  }
}


//return Tab(
//child: InkWell(
//onTap:onTap,
//child: Container(
//padding: EdgeInsets.all(5.0),
//width: ScreenUtil().setWidth(360),
//height: ScreenUtil().setHeight(140),
//alignment: Alignment.center,
//child: Text(
//title,
//style: TextStyle(
//color: current
//? Colors.pinkAccent
//    : Colors.black),
//),
//),
//),
//);
