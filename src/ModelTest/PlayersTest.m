#import <XCTest/XCTest.h>

#import "Players.h"

@interface PlayersTest : XCTestCase

@end

@implementation PlayersTest

static NSString* _json;

+ (void)setUp
{
	NSBundle* bundle = [NSBundle bundleForClass:self.class];
	NSString* path = [bundle pathForResource:@"Players" ofType:@"json"];
	_json = [NSString stringWithContentsOfFile:path
									  encoding:NSUTF8StringEncoding
										 error:NULL];
}

- (void)testLoadJson
{
	Players* players = [Players loadJson:_json];
	XCTAssertNotNil(players);
}

@end
