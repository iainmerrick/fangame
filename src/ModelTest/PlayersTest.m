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

	Player* a = arr[0];
	XCTAssertEqualObjects(a.firstName, @"A");
	XCTAssertEqualObjects(a.lastName, @"1");
	XCTAssertEqual(a.fppg, 1.0);

	Player* b = arr[1];
	XCTAssertEqualObjects(b.firstName, @"B");
	XCTAssertEqualObjects(b.lastName, @"2");
	XCTAssertEqual(b.fppg, 1.5);

	Player* c = arr[2];
	XCTAssertEqualObjects(c.firstName, @"C");
	XCTAssertEqualObjects(c.lastName, @"3");
	XCTAssertEqual(c.fppg, 2.0);
}

@end
