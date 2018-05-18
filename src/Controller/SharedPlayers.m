#import "SharedPlayers.h"

@implementation SharedPlayers
{
	Players* _players;
	NSMutableArray* _blocks;
}

static NSURL* _url;
static SharedPlayers* _shared;

+ (void)setUrl:(NSURL*)url
{
	NSAssert(url, @"URL must be non-nil");
	_url = url;
	_shared = nil;
}

+ (instancetype)shared
{
	if (!_shared) {
		_shared = [[SharedPlayers alloc] initWithUrl:_url];
	}
	return _shared;
}

+ (void)load:(LoadPlayersBlock)completion
{
	SharedPlayers* shared = [SharedPlayers shared];
	[shared->_blocks addObject:completion];
	[shared maybeRunBlocks];
}

- (instancetype)initWithUrl:(NSURL*)url
{
	if (!url) {
		url = [NSURL URLWithString:@"https://gist.githubusercontent.com/liamjdouglas/"
		                           @"bb40ee8721f1a9313c22c6ea0851a105/raw/"
		                           @"6b6fc89d55ebe4d9b05c1469349af33651d7e7f1/Player.json"];
	}

	self = [super init];
	if (self) {
		_blocks = [NSMutableArray array];

		NSURLSessionDataTask* task = [[NSURLSession sharedSession]
		      dataTaskWithURL:url
		    completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
			    // TODO: handle failure. This would typically be caused by a bad
			    // network connection. Backoff and retry? Display an error message?
			    dispatch_async(dispatch_get_main_queue(), ^{
				    self->_players = [[Players alloc] initWithData:data url:url error:NULL];
				    [self maybeRunBlocks];
			    });
		    }];
		[task resume];
	}
	return self;
}

- (void)maybeRunBlocks
{
	if (_players) {
		dispatch_async(dispatch_get_main_queue(), ^{
			for (LoadPlayersBlock block in self->_blocks) {
				block(self->_players);
			}
			[self->_blocks removeAllObjects];
		});
	}
}

@end
