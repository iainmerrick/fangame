#import "SharedPlayers.h"

NSString* const SHARED_PLAYERS_URL = @"FAN_GAME_SHARED_PLAYERS_URL";

@implementation SharedPlayers
{
	Players* _players;
	NSMutableArray* _blocks;
}

static SharedPlayers* _shared;

+ (instancetype)shared
{
    NSLog(@"Shared address: %p", &_shared);
	if (!_shared) {
        NSLog(@"Initializing!");
        _shared = [[SharedPlayers alloc] init];
	}
	return _shared;
}

+ (void)reset
{
    _shared = nil;
}

+ (void)load:(LoadPlayersBlock)completion
{
	SharedPlayers* shared = [SharedPlayers shared];
	[shared->_blocks addObject:completion];
	[shared maybeRunBlocks];
}

- (instancetype)init
{
    NSString* urlStr = [NSProcessInfo processInfo].environment[SHARED_PLAYERS_URL];
    if (!urlStr) {
        urlStr = @"https://gist.githubusercontent.com/liamjdouglas/bb40ee8721f1a9313c22c6ea0851a105/raw/6b6fc89d55ebe4d9b05c1469349af33651d7e7f1/Player.json";
    }

    NSURL* url = [NSURL URLWithString:urlStr];

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
