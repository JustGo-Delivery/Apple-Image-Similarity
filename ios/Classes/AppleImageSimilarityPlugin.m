#import "AppleImageSimilarityPlugin.h"
#if __has_include(<apple_image_similarity/apple_image_similarity-Swift.h>)
#import <apple_image_similarity/apple_image_similarity-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "apple_image_similarity-Swift.h"
#endif

@implementation AppleImageSimilarityPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppleImageSimilarityPlugin registerWithRegistrar:registrar];
}
@end
