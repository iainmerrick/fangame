#import <XCTest/XCTest.h>

#import "SharedPlayers.h"

@interface SharedPlayersTest : XCTestCase

@end

@implementation SharedPlayersTest

- (void)testLoad
{
	NSBundle* bundle = [NSBundle bundleForClass:self.class];
	NSURL* url = [bundle URLForResource:@"TestData/Players" withExtension:@"json"];

	[SharedPlayers setUrl:url];

	XCTestExpectation* expectation = [self expectationWithDescription:@"LoadPlayersBlock"];
	[SharedPlayers load:^(Players* players) {
		XCTAssertEqualObjects(players.players[0].firstName, @"A");
		[expectation fulfill];
	}];

	[self waitForExpectationsWithTimeout:1 handler:NULL];
}

@end
