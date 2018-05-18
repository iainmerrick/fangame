#import "PlayerView.h"

@implementation PlayerView
{
	int _imageTaskCookie;
	NSURLSessionDataTask* _imageTask;
}

+ (NSString*)imageViewAccessibilityLabel { return @"PlayerView_imageView"; }

+ (NSString*)nameAccessibilityLabel { return @"PlayerView_name"; }

- (instancetype)initWithCoder:(NSCoder*)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) [self finishInit];
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) [self finishInit];
	return self;
}

- (void)finishInit
{
	_imageView = [[UIImageView alloc] initWithFrame:self.bounds];
	_imageView.accessibilityLabel = [self.class imageViewAccessibilityLabel];
	_imageView.contentMode = UIViewContentModeScaleAspectFit;

	_name = [[UILabel alloc] initWithFrame:self.bounds];
	_name.accessibilityLabel = [self.class imageViewAccessibilityLabel];
	_name.textAlignment = NSTextAlignmentCenter;

	[self addSubview:_imageView];
	[self addSubview:_name];
}

- (void)setPlayer:(Player*)player
{
	_player = player;
	_name.text = [NSString stringWithFormat:@"%@ %@", player.firstName, player.lastName];

	NSURLSession* session = [NSURLSession sharedSession];

	// This is used to disambiguate task callbacks.
	int expectedCookie = ++_imageTaskCookie;

	NSURLSessionDataTask* task =
	    [session dataTaskWithURL:player.imageUrl
	           completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
		           dispatch_async(dispatch_get_main_queue(), ^{
			           if (self->_imageTaskCookie != expectedCookie) {
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
