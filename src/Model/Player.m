#import "Player.h"

@implementation Player

- (instancetype)initWithJsonObject:(NSDictionary*)json
{
	NSAssert(json, @"json must be non-nil");

	self = [super init];
	if (self) {
		// Do something useful with this...
		NSLog(@"Player: %@", json);
	}
	return self;
}

+ (instancetype)loadJsonObject:(NSDictionary*)json
{
	return [[Player alloc] initWithJsonObject:json];
}

@end
