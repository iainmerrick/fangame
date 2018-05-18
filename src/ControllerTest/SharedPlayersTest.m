#import <XCTest/XCTest.h>

#include <stdlib.h>

#import "SharedPlayers.h"

@interface SharedPlayersTest : XCTestCase

@end

@implementation SharedPlayersTest

- (void)testLoad
{
	NSBundle* bundle = [NSBundle bundleForClass:self.class];
	NSURL* url = [bundle URLForResource:@"TestData/Players" withExtension:@"json"];

	// Poke the environment variable. Unfortunately I can't really use the correct
	// XCTest infrastructure, as the test has a different environment from the app
	// under test! TODO: find a tidier way to do this.
	setenv(SHARED_PLAYERS_URL.UTF8String, url.absoluteString.UTF8String, YES);
	[SharedPlayers reset];

	XCTestExpectation* expectation = [self expectationWithDescription:@"LoadPlayersBlock"];
	[SharedPlayers load:^(Players* players) {
		XCTAssertEqualObjects(players.players[0].firstName, @"A");
		[expectation fulfill];
	}];

	[self waitForExpectationsWithTimeout:1 handler:NULL];
}

@end
