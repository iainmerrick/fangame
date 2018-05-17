#import <UIKit/UIKit.h>

#import "Player.h"

@class PlayerView;

@protocol PlayerViewDelegate

- (void)playerViewImageLoaded:(PlayerView*)view;
- (void)playerViewImageFailed:(PlayerView*)view error:(NSError*)error;

@end

@interface PlayerView : UIView

@property (nonatomic, weak) id<PlayerViewDelegate> delegate;
@property (nonatomic) Player* player;

@property (nonatomic, readonly) UIImageView* imageView;
@property (nonatomic, readonly) UILabel* label;

@end
