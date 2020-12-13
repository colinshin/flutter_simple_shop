import 'package:demo1/util/image_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:palette_generator/palette_generator.dart';

class ColorUtil{

  /// 获取图片的主要颜色
  static Future<Color> getImageMainColor(String netImageUrl)async{
    PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(MImageUtils.magesProcessor(netImageUrl)),
      maximumColorCount: 20,
    );
    return paletteGenerator.dominantColor.color;
  }
}