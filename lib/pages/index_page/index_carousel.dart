import 'package:demo1/config/app_config.dart';
import 'package:demo1/pages/index_page/model/index_carousel_item_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'index_layout.dart';

class IndexCarousel extends StatefulWidget {
  @override
  _IndexCarouselState createState() => _IndexCarouselState();
}

class _IndexCarouselState extends State<IndexCarousel> {
  List<IndexCarouselItemModel> _carouselList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  /// 加载本地静态数据
  void _getData() {
    setState(() {
      _carouselList = indexCarouselsStateDatas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.h,
      margin: EdgeInsets.symmetric(horizontal: 50.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.sp)),
          color: Colors.transparent),
      child: IndexPublicLayout(
        transparencyBg: true,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.all(Radius.circular(50.sp)),
        child: Swiper(
          autoplay: _carouselList.isNotEmpty,
          duration: 1000,
          loop: true,
          onTap: (int index) async {
            IndexCarouselItemModel item = _carouselList[index];
            if (item.clickType == "brower" && await canLaunch(item.params)) {
              await launch(item.params);
            }
          },
          onIndexChanged: (index) {
            Future.delayed(Duration(seconds: 0), () {
              IndexCarouselItemModel item = _carouselList[index];
              _updatePaletteGenerator(index, item.imageUrl);
            });
          },
          itemBuilder: (BuildContext context, int index) {
            IndexCarouselItemModel item = _carouselList[index];
            return ExtendedImage.network(
              item.imageUrl,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.all(Radius.circular(50.sp)),
              shape: BoxShape.rectangle,
            );
          },
          itemCount: _carouselList.length,
          pagination: new SwiperPagination(),
          // viewportFraction: 0.8,
          // scale: 0.9,
        ),
      ),
    );
  }

  Future<void> _updatePaletteGenerator(int index, String url) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(url),
      maximumColorCount: 20,
    );
  }
}
