#import <UIKit/UIKit.h>

#import "Player.h"

@interface PlayerView : UIView

@property (nonatomic) Player* player;

// These fields will be (re-)initialized when 'player' is set.
@property (nonatomic, readonly) UIImageView* image;
@property (nonatomic, readonly) UILabel* label;

@end
