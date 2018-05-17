#import "PlayerView.h"

@implementation PlayerView
{
	int _imageTaskCount;
	NSURLSessionDataTask* _imageTask;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		_imageView = [[UIImageView alloc] init];
		_label = [[UILabel alloc] init];

		[self addSubview:_imageView];
		[self addSubview:_label];
	}
	return self;
}

- (void)setPlayer:(Player*)player
{
	_player = player;
	_label.text = [NSString stringWithFormat:@"%@ %@", player.firstName, player.lastName];

	NSURLSession* session = [NSURLSession sharedSession];

	int expectedCount = ++_imageTaskCount;
	NSURLSessionDataTask* task =
	    [session dataTaskWithURL:player.imageUrl
	           completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
		           dispatch_async(dispatch_get_main_queue(), ^{
			           if (self->_imageTaskCount != expectedCount) {
				           // This is an old task, not the one we're currently waiting for.
				           return;
			           }
			           if (error) {
				           [self.delegate playerViewImageFailed:self error:error];
				           return;
			           }
			           self.imageView.image = [UIImage imageWithData:data];
			           [self.delegate playerViewImageLoaded:self];
		           });
	           }];

	[_imageTask cancel];
	_imageTask = task;
	[_imageTask resume];
}

@end
