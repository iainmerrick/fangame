#import <XCTest/XCTest.h>

#import "Players.h"

@interface PlayersTest : XCTestCase

@end

@implementation PlayersTest

static NSBundle* _bundle;
static NSURL* _url;
static NSData* _data;

+ (void)setUp
{
	_bundle = [NSBundle bundleForClass:self.class];
	_url = [_bundle URLForResource:@"Data/Players" withExtension:@"json"];
	_data = [NSData dataWithContentsOfURL:_url];
}

- (void)testLoadJson
{
	NSError* error;
	Players* players = [[Players alloc] initWithData:_data url:_url error:&error];
	XCTAssertNil(error);
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

- (void)testRelativeImageUrl
{
	NSError* error;
	Players* players = [[Players alloc] initWithData:_data url:_url error:&error];
	XCTAssertNil(error);
	XCTAssertNotNil(players);

	Player* a = players.players[0];

	NSURL* expected = [_bundle URLForResource:@"Data/A" withExtension:@"png"];
	XCTAssertEqualObjects(a.imageUrl.absoluteURL, expected.absoluteURL);
}

@end
