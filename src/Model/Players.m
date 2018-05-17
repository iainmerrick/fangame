#import "Players.h"

@implementation Players

- (instancetype)initWithData:(NSData*)data url:(NSURL*)url error:(NSError**)error
{
	id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
	if (!json) return nil;

	return [self initWithJson:json url:url error:error];
}

- (instancetype)initWithJson:(NSDictionary*)json url:(NSURL*)url error:(NSError**)error
{
	NSAssert(json, @"json must be non-nil");

	self = [super init];
	if (self) {
		NSArray* json_players = json[@"players"];
		NSMutableArray* players = [NSMutableArray arrayWithCapacity:json_players.count];
		for (NSDictionary* p in json_players) {
			Player* player = [[Player alloc] initWithJson:p url:url];
			[players addObject:player];
		}
		_players = [NSArray arrayWithArray:players];
	}
	return self;
}

@end
