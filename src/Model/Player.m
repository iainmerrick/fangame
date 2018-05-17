#import "Player.h"

@implementation Player

- (instancetype)initWithJson:(NSDictionary*)json url:(NSURL*)url
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
		_imageSize = CGSizeMake([image[@"width"] doubleValue], [image[@"height"] doubleValue]);
		_imageUrl = [[NSURL alloc] initWithString:image[@"url"] relativeToURL:url];
	}
	return self;
}

@end
