#import "FileLoader.h"

@implementation FileLoader

- (instancetype)initWithPath:(NSString*)path
{
	self = [super init];
	if (self) {
		_path = path;
	}
	return self;
}

- (void)loadUrl:(NSString*)url completion:(LoadCompletionBlock)block
{
	NSString* path = [_path stringByAppendingPathComponent:url];
	NSError* err;
	NSData* data = [NSData dataWithContentsOfFile:path
										  options:NSDataReadingMappedIfSafe
											error:&err];
	if (err) {
		block(nil, nil, err);
	}
	NSString* dir = path.stringByDeletingLastPathComponent;
	FileLoader* subloader = [FileLoader loaderWithPath:dir];
	block(data, subloader, nil);
}

+ (instancetype)loaderWithPath:(NSString*)path
{
	return [[FileLoader alloc] initWithPath:path];
}

@end
