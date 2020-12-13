import 'package:demo1/pages/index_page/model/topic_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:demo1/provider/index_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

/// 精选专题首页轮播
class IndexTopicComponentCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<MainTopic> topics = Provider.of<IndexProvider>(context).mainTopic;
    topics.removeWhere((element) => element.banner.isEmpty);
    return Container(
      height: 500.h,
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      child: Swiper(
        autoplay: topics.isNotEmpty,
        duration: 1000,
        loop: true,
        onTap: (int index) async {
          MainTopic mainTopic = topics[index];
          print("点击了主题${mainTopic.topicId}");
        },
        onIndexChanged: (index) {
          if (topics.isNotEmpty) {
            Future.delayed(Duration(seconds: 0), () {
              MainTopic mainTopic = topics[index];
              Provider.of<IndexProvider>(context, listen: false).changeToColor(mainTopic.banner[0]);
            });
          }
        },
        itemBuilder: (BuildContext context, int index) {
          MainTopic mainTopic = topics[index];
          return ExtendedImage.network(
            mainTopic.banner[0],
            fit: BoxFit.cover,
            borderRadius: BorderRadius.all(Radius.circular(50.sp)),
            shape: BoxShape.rectangle,
          );
        },
        itemCount: topics.length,
        pagination: new SwiperPagination(),
        // viewportFraction: 0.8,
        // scale: 0.9,
      ),
    );
  }
}
