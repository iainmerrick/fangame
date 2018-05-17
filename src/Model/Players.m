#import "Players.h"

@implementation Players

+ (void)withUrl:(NSString*)url loader:(id<Loader>)loader completion:(PlayersCompletionBlock)block
{
	[loader loadUrl:url
	     completion:^(NSData* data, id<Loader> subloader, NSError* error) {
		     if (error) {
			     block(nil, error);
		     } else {
			     Players* result =
			         [[Players alloc] initWithData:data loader:subloader error:&error];
			     block(result, error);
		     }
	     }];
}

- (instancetype)initWithData:(NSData*)data loader:(id<Loader>)loader error:(NSError**)error
{
	id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:error];
	if (!json) return nil;

	return [self initWithJson:json loader:loader error:error];
}

- (instancetype)initWithJson:(NSDictionary*)json loader:(id<Loader>)loader error:(NSError**)error
{
	NSAssert(json, @"json must be non-nil");

	self = [super init];
	if (self) {
		NSArray* json_players = json[@"players"];
		NSMutableArray* players = [NSMutableArray arrayWithCapacity:json_players.count];
		for (NSDictionary* p in json_players) {
			Player* player = [[Player alloc] initWithJson:p];
			[players addObject:player];
		}
		_players = [NSArray arrayWithArray:players];
	}
	return self;
}

@end
