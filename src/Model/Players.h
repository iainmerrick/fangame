#import <Foundation/Foundation.h>

#import "Player.h"

//
// A collection of players and related info.
//
@interface Players : NSObject

@property (nonatomic, readonly) NSArray<Player*>* players;

+ (Players*)loadJson:(NSString*)json;

@end
