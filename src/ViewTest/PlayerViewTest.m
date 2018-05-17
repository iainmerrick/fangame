#import <XCTest/XCTest.h>

#import "PlayerView.h"
#import "Players.h"

@interface PlayerViewTest : XCTestCase

@end

@implementation PlayerViewTest

- (void)setUp
{
	[super setUp];
	self.continueAfterFailure = NO;
	[[[XCUIApplication alloc] init] launch];
}

- (void)testLoadPlayer
{
	NSBundle* bundle = [NSBundle bundleForClass:self.class];
	NSURL* url = [bundle URLForResource:@"TestData/Players" withExtension:@"json"];
	NSData* data = [NSData dataWithContentsOfURL:url];
	Players* players = [[Players alloc] initWithData:data url:url error:NULL];
	Player* a = players.players[0];

	PlayerView* view = [[PlayerView alloc] initWithFrame:CGRectZero];
	view.player = a;

	XCTAssertEqualObjects(view.label.text, @"A 1");
}

@end
