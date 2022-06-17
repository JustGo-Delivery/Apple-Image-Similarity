import 'dart:typed_data';

import 'package:flutter/services.dart';

class AppleImageSimilarity {
  final methodChannel = const MethodChannel('apple_image_similarity');

  Future<Uint8List> computeFeaturePrintFromNetwork(String url) async {
    return (await methodChannel.invokeMethod<Uint8List>('computeFeaturePrintFromNetwork', url))!;
  }

  Future<Uint8List> computeFeaturePrintFromMemory(Uint8List bytes) async {
    return (await methodChannel.invokeMethod<Uint8List>('computeFeaturePrintFromMemory', bytes))!;
  }

  Future<double> computeDistance(Uint8List featurePrint1, Uint8List featurePrint2) async {
    return (await methodChannel.invokeMethod<double>('computeDistance', [featurePrint1, featurePrint2]))!;
  }
}
