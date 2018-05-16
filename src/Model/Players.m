#import "Players.h"

@implementation Players

- (instancetype)initWithJson:(NSString*)json
{
	NSAssert(json, @"json must be non-nil");

	self = [super init];
	if (self) {
		// Do something useful with this...
		NSLog(@"%@", json);
	}
	return self;
}

+ (Players*)loadJson:(NSString*)json
{
	return [[Players alloc] initWithJson:json];
}

@end
