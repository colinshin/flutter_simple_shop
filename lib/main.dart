import 'package:flutter/material.dart';
import 'package:demo1/constant/color.dart';
import 'package:demo1/provider/user_provider.dart';
import 'package:nav_router/nav_router.dart';
import 'package:provider/provider.dart';
import './app.dart';
import './provider/providers.dart';
import 'package:fluro/fluro.dart';
import './fluro/Application.dart';
import './fluro/Routes.dart';
// 路由配置-----end

void main() {
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '典典小卖部',
          //自定义主题
          navigatorKey: navGK,
          // 声明路由
          onGenerateRoute: Application.router.generator,
          home: new App(),
        ),
      ),
    );
  }
}



