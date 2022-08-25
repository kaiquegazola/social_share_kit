#import "SocialShareKitPlugin.h"

#if __has_include(<social_share_kit/social_share_kit-Swift.h>)

#import <social_share_kit/social_share_kit-Swift.h>

#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "social_share_kit-Swift.h"
#endif

@implementation SocialShareKitPlugin
+ (void)registerWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar {
    [SwiftSocialShareKitPlugin registerWithRegistrar:registrar];
}
@end
