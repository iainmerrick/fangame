#import <XCTest/XCTest.h>

#import "PlayerView.h"
#import "SharedPlayers.h"

@interface FanGameTest : XCTestCase

@end

@implementation FanGameTest
{
	XCUIApplication* _app;
}

- (void)setUp
{
	[super setUp];

	NSBundle* bundle = [NSBundle bundleForClass:self.class];
	NSURL* url = [bundle URLForResource:@"TestData/Players" withExtension:@"json"];

	_app = [[XCUIApplication alloc] init];
	NSMutableDictionary* env = _app.launchEnvironment.mutableCopy;
	env[SHARED_PLAYERS_URL] = url;
	_app.launchEnvironment = env;
	[_app launch];
}

- (void)testName
{
	XCUIElement* name = _app.textFields[PlayerView.nameAccessibilityLabel];
	XCTAssertEqualObjects(name.value, @"A 1");
}

@end
