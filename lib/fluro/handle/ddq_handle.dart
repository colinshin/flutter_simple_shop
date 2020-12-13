import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../../pages/ddq_page/index_home.dart';

var ddqHandle = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> params){
    return DdqIndexHome();
  }
);