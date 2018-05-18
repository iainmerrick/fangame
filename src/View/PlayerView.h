#import <UIKit/UIKit.h>

#import "Player.h"

@class PlayerView;

@protocol PlayerViewDelegate

- (void)playerViewImageLoaded:(PlayerView*)view;
- (void)playerViewImageFailed:(PlayerView*)view error:(NSError*)error;

- (void)playerViewTapped:(PlayerView*)view;

@end

@interface PlayerView : UIView

@property (nonatomic, weak) IBOutlet id<PlayerViewDelegate> delegate;
@property (nonatomic) Player* player;

@property (nonatomic, readonly) UIImageView* imageView;
@property (nonatomic, readonly) UILabel* name;

@property (class, readonly) NSString* imageViewAccessibilityLabel;
@property (class, readonly) NSString* nameAccessibilityLabel;

@end
