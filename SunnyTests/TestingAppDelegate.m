#import "TestingAppDelegate.h"

@implementation TestingAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

@end

BOOL isRunningTests(void) {
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    NSString *injectBundle = environment[@"XCInjectBundle"];
    return [[injectBundle pathExtension] isEqualToString:@"xctest"];
}
