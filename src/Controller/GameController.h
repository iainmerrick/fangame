#import <UIKit/UIKit.h>

#import "PlayerView.h"

@interface GameController : UIViewController <PlayerViewDelegate>

@property IBOutlet PlayerView* playerView;

@end
