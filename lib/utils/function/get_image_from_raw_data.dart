import 'dart:ui' as ui;
import 'package:flutter/services.dart';

Future<Uint8List> getImageFromRawData({required String image,required double width}) async {
  var imageData = await rootBundle.load(image);
  var imageCode = await ui.instantiateImageCodec(imageData.buffer.asUint8List(),targetHeight: width.round());
  var imageFrame = await imageCode.getNextFrame();
  var imageByteData= await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);
  return imageByteData!.buffer.asUint8List();
}