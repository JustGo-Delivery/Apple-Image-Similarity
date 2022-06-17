import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:apple_image_similarity/apple_image_similarity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _appleImageSimilarityPlugin = AppleImageSimilarity();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    const snowAppleUrl = "https://justgo-prod.imgix.net/a01a1f4a-534f-4d23-a737-cb5a3d0121de";
    const fujiAppleUrl = "https://justgo-prod.imgix.net/164529e7-bec6-4e12-8e92-6cab3f34fc35";
    const bananasUrl = "https://justgo-prod.imgix.net/8b150e6e-3e0d-4c73-9b51-9b63a8676f76";
    
    Uint8List snowAppleFeatureMap = await AppleImageSimilarity().computeFeaturePrintFromNetwork(snowAppleUrl);

    print("Snow Apple: ${snowAppleFeatureMap.length}");

    Uint8List fujiAppleFeatureMap = await AppleImageSimilarity().computeFeaturePrintFromNetwork(fujiAppleUrl);

    print("Fuji Apple: ${fujiAppleFeatureMap.length}");

    Uint8List bananasFeatureMap = await AppleImageSimilarity().computeFeaturePrintFromNetwork(bananasUrl);

    print("Bananas: ${bananasFeatureMap.length}");

    print(
    """
apples: ${await AppleImageSimilarity().computeDistance(snowAppleFeatureMap, fujiAppleFeatureMap)},
apple and banana: ${await AppleImageSimilarity().computeDistance(bananasFeatureMap, fujiAppleFeatureMap)}
    """);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
