#import "PlayerView.h"

@implementation PlayerView

- (void)setPlayer:(Player*)player
{
	_player = player;

	[_image removeFromSuperview];
	_image = nil;

	[_label removeFromSuperview];
	_label = nil;

	_label = [[UILabel alloc] init];
	_label.text = [NSString stringWithFormat:@"%@ %@", player.firstName, player.lastName];
}

@end
