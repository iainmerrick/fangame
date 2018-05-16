#import "Player.h"

@implementation Player

- (instancetype)initWithJsonObject:(NSDictionary*)json
{
	NSAssert(json, @"json must be non-nil");

	self = [super init];
	if (self) {
		// TODO: check that these fields have the correct types.
		// (Right now we'll probably crash if they're not.)
		_firstName = json[@"first_name"];
		_lastName = json[@"last_name"];
		_fppg = [json[@"fppg"] doubleValue];

		NSDictionary* image = json[@"images"][@"default"];
		_imageSize = CGSizeMake(
			[image[@"width"] doubleValue], [image[@"height"] doubleValue]);
	}
	return self;
}

+ (instancetype)loadJsonObject:(NSDictionary*)json
{
	return [[Player alloc] initWithJsonObject:json];
}

@end
