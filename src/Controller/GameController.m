#import "GameController.h"

#import "SharedPlayers.h"

@implementation GameController

- (void)viewDidLoad
{
	[super viewDidLoad];

	[SharedPlayers load:^(Players* players) {
		self.playerView.player = players.players[0];
	}];
}

- (void)playerViewImageLoaded:(PlayerView*)view
{
	// Nothing yet
}

- (void)playerViewImageFailed:(PlayerView*)view error:(NSError*)error
{
	// Nothing yet
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
