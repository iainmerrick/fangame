#import <XCTest/XCTest.h>

#import "Players.h"

@interface PlayersTest : XCTestCase

@end

@implementation PlayersTest

static NSData* _json;

+ (void)setUp
{
	NSBundle* bundle = [NSBundle bundleForClass:self.class];
	NSString* path = [bundle pathForResource:@"Players" ofType:@"json"];
	_json = [NSData dataWithContentsOfFile:path];
}

- (void)testLoadJson
{
	Players* players = [Players loadData:_json];
	XCTAssertNotNil(players);

	// Note: hmm, I'm not too happy with "players.players"!
	// But it does fit with the provided JSON structure.
	NSArray<Player*>* arr = players.players;
	XCTAssertEqual(arr.count, 3);
}

@end
