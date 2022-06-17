import Flutter
import UIKit
import Vision

public class SwiftAppleImageSimilarityPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "apple_image_similarity", binaryMessenger: registrar.messenger())
    let instance = SwiftAppleImageSimilarityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch (call.method) {
    case "computeFeaturePrintFromMemory" :
      computeFeaturePrintFromMemory(call, result: result);
      break;
      
    case "computeFeaturePrintFromNetwork" :
      computeFeaturePrintFromNetwork(call, result: result);
      break;
      
    case "computeDistance" :
      computeDistance(call, result: result);
      break;
      
    default:
      result(FlutterMethodNotImplemented);
    }
  }
}

private func computeDistance(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  DispatchQueue.global().async {
    do {
      let arguments = call.arguments as! Array<FlutterStandardTypedData>;
      
      let data1 = arguments[0].data;
      let data2 = arguments[1].data;
      
      let featurePrint1 = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data1) as! VNFeaturePrintObservation;
      
      let featurePrint2 = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data2) as! VNFeaturePrintObservation;
      
      var distance = Float(0);
      
      try featurePrint1.computeDistance(&distance, to: featurePrint2);
      
      result(NSNumber(value: Double(distance)));
      
    } catch {
      result(FlutterError(code: "Platform Error", message: "Vision error: \(error)", details: nil));
    }
  }
}

private func computeFeaturePrintFromNetwork(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  DispatchQueue.global().async {
    do {
      let url = call.arguments as! String;
              
      let requestHandler = VNImageRequestHandler(url: URL(string: url)!);

      let request = VNGenerateImageFeaturePrintRequest()
    
      try requestHandler.perform([request]);
      
      let featurePrint = (request.results?.first)! as VNFeaturePrintObservation;
      
      let archivedFeaturePrint = try NSKeyedArchiver.archivedData(withRootObject: featurePrint, requiringSecureCoding: true);

      result(FlutterStandardTypedData(bytes: archivedFeaturePrint));
 
    } catch {
      result(FlutterError(code: "Platform Error", message: "Vision error: \(error)", details: nil));
    }
  }
}

private func computeFeaturePrintFromMemory(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  DispatchQueue.global().async {
    do {
      let data = (call.arguments as! FlutterStandardTypedData).data;
              
      let requestHandler = VNImageRequestHandler(data: data);

      let request = VNGenerateImageFeaturePrintRequest()
    
      try requestHandler.perform([request]);
      
      let featurePrint = (request.results?.first)! as VNFeaturePrintObservation;
      
      let archivedFeaturePrint = try NSKeyedArchiver.archivedData(withRootObject: featurePrint, requiringSecureCoding: true);

      result(FlutterStandardTypedData(bytes: archivedFeaturePrint));
 
    } catch {
      result(FlutterError(code: "Platform Error", message: "Vision error: \(error)", details: nil));
    }
  }
}

//  do {
//      var distance = Float(0)
//      try contestantFPO.computeDistance(&distance, to: originalFPO)
//      ranking.append((contestantIndex: idx, featureprintDistance: distance))
//  } catch {
//      print("Error computing distance between featureprints.")
//  }
//
//    func featureprintObservationForImage(atURL url: URL) -> VNFeaturePrintObservation? {
//        let requestHandler = VNImageRequestHandler(url: url, options: [:])
//
//        let request = VNGenerateImageFeaturePrintRequest()
//        do {
//            try requestHandler.perform([request])
//            return request.results?.first as? VNFeaturePrintObservation
//        } catch {
//            print("Vision error: \(error)")
//            return nil
//        }
//
//      let myPrint = VNFeaturePrintObservation(coder: <#T##NSCoder#>)
//    }
