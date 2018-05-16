#import "Players.h"

@implementation Players

- (instancetype)initWithJsonObject:(NSDictionary*)json
{
	NSAssert(json, @"json must be non-nil");

	self = [super init];
	if (self) {
		NSArray* json_players = json[@"players"];
		NSMutableArray* players =
			[NSMutableArray arrayWithCapacity:json_players.count];
		for (NSDictionary* p in json_players) {
			Player* player = [Player loadJsonObject:p];
			[players addObject:player];
		}
		_players = [NSArray arrayWithArray:players];
	}
	return self;
}

+ (instancetype)loadData:(NSData*)data
{
	id json =
		[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
	if (!json) return nil;
	return [self loadJsonObject:json];
}

+ (instancetype)loadJsonObject:(NSDictionary*)json
{
	return [[Players alloc] initWithJsonObject:json];
}

@end
