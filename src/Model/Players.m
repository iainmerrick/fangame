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
		NSMutableArray* players = [NSMutableArray array];
		for (NSDictionary* p in json[@"players"]) {
            @try {
                Player* player = [[Player alloc] initWithJson:p url:url];
                [players addObject:player];
            } @catch (NSException* e) {
                // TODO: How should we handle bad player data?
                // For now, just log it and skip it.
                NSLog(@"Error parsing Player record: %@", e.reason);
            }
        }
		_players = [NSArray arrayWithArray:players];
	}
	return self;
}

@end
