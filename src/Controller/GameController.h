#import <UIKit/UIKit.h>

#import "PlayerView.h"

@interface GameController : UIViewController <PlayerViewDelegate>

@property IBOutlet UIView* content;

@property IBOutlet UILabel* label;
@property IBOutlet UIButton* button;

@property IBOutlet PlayerView* left;
@property IBOutlet PlayerView* right;

- (IBAction)buttonTapped;

@end
