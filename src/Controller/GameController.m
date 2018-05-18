#import "GameController.h"

#import "SharedPlayers.h"

@implementation GameController
{
	Players* _players;
	BOOL _playing;
	int _score;
	int _attempts;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Hide the UI until our database is loaded.
	self.content.alpha = 0;
	[SharedPlayers load:^(Players* players) {
		self->_players = players;
		[self intro];
	}];
}

- (void)intro
{
	_playing = NO;
	_left.player = nil;
	_right.player = nil;

	[UIView animateWithDuration:0.5
	                 animations:^{
		                 self.content.alpha = 1;
	                 }];
}

- (void)begin
{
	_playing = YES;
	_score = 0;
	_attempts = 0;

	[self showChoice];
}

- (void)end
{
	_playing = NO;
	_left.player = nil;
	_right.player = nil;

	[self update];
}

- (void)showChoice
{
	Player* left = [self randomPlayer];
	Player* right = [self randomPlayer];
	while (left == right || left.fppg == right.fppg) {
		right = [self randomPlayer];
	}

	_left.player = left;
	_right.player = right;
	[self update];
}

- (void)update
{
	if (_attempts == 0) {
		_label.text = @"Who has the highest FPPG?";
	} else if (!_playing) {
		int percent = (100 * _score) / _attempts;
		_label.text =
		    [NSString stringWithFormat:@"Final score: %d / %d (%d%%)", _score, _attempts, percent];
	} else {
		_label.text = [NSString stringWithFormat:@"Score: %d / %d", _score, _attempts];
	}

	NSString* button;
	if (_playing) {
		button = @"Quit";
	} else if (_attempts == 0) {
		button = @"Begin";
	} else {
		button = @"Try again";
	}
	[_button setTitle:button forState:UIControlStateNormal];
}

- (void)playerViewTapped:(PlayerView*)view
{
	if (!_playing) return;

	PlayerView* other = (view == _left) ? _right : _left;
	if (view.player.fppg >= other.player.fppg) {
		++_score;
	}
	++_attempts;

	if (_score >= 10) {
		[self end];
	} else {
		[self showChoice];
	}
}

- (void)buttonTapped
{
	if (_playing) {
		[self end];
	} else {
		[self begin];
	}
}

- (void)playerViewImageLoaded:(PlayerView*)view
{
	// Nothing yet -- could use this to fade players in simultaneously
}

- (void)playerViewImageFailed:(PlayerView*)view error:(NSError*)error
{
	// Nothing yet -- probably want to retry, or try a different player
}

- (Player*)randomPlayer
{
	uint32_t i = arc4random_uniform((uint32_t)_players.players.count);
	return _players.players[i];
}

@end
