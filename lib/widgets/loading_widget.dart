import 'package:demo1/util/extended_util.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height:bodyHeight(context),
      width: pw(context),
      child: Center(
        child: CircularProgressIndicator(backgroundColor: Colors.red),
      ),
    );
  }
}
