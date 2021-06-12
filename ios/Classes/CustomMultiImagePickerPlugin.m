#import "CustomMultiImagePickerPlugin.h"
#if __has_include(<custom_multi_image_picker/custom_multi_image_picker-Swift.h>)
#import <custom_multi_image_picker/custom_multi_image_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "custom_multi_image_picker-Swift.h"
#endif

@implementation CustomMultiImagePickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCustomMultiImagePickerPlugin registerWithRegistrar:registrar];
}
@end
