#import <Foundation/Foundation.h>

#import "Loader.h"
#import "Player.h"

@class Players;

typedef void (^PlayersCompletionBlock)(Players* players, NSError* error);

//
// A collection of players and related info.
//
@interface Players : NSObject

@property (nonatomic, readonly) NSArray<Player*>* players;

//
// Create a Players object asynchronously from the specified URL.
//
+ (void)withUrl:(NSString*)url loader:(id<Loader>)loader completion:(PlayersCompletionBlock)block;

- (instancetype)initWithData:(NSData*)data loader:(id<Loader>)loader error:(NSError**)error;
- (instancetype)initWithJson:(NSDictionary*)json loader:(id<Loader>)loader error:(NSError**)error;

@end
