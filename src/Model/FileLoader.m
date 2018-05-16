#import "FileLoader.h"

static dispatch_queue_t _background_queue;

@implementation FileLoader

+ (void)initialize
{
	if (self == FileLoader.class) {
		_background_queue =
			dispatch_queue_create("FileLoader", DISPATCH_QUEUE_CONCURRENT);
	}
}

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
	dispatch_async(_background_queue, ^{
		NSError* err;
		NSData* data = [NSData dataWithContentsOfFile:path
											  options:NSDataReadingMappedIfSafe
												error:&err];
		if (err) {
			dispatch_async(dispatch_get_main_queue(), ^{
				block(nil, nil, err);
			});
		}
		NSString* dir = path.stringByDeletingLastPathComponent;
		FileLoader* subloader = [FileLoader loaderWithPath:dir];
		dispatch_async(dispatch_get_main_queue(), ^{
			block(data, subloader, nil);
		});
	});
}

+ (instancetype)loaderWithPath:(NSString*)path
{
	return [[FileLoader alloc] initWithPath:path];
}

@end
