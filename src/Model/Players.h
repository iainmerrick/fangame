#import <Foundation/Foundation.h>

#import "Player.h"

//
// A collection of players and related info.
//
@interface Players : NSObject

@property (nonatomic, readonly) NSArray<Player*>* players;

+ (instancetype)loadData:(NSData*)data;
+ (instancetype)loadJsonObject:(NSDictionary*)json;

@end
