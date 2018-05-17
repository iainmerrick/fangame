#import <Foundation/Foundation.h>

#import "Player.h"

@class Players;

//
// A collection of players and related info.
//
@interface Players : NSObject

@property (nonatomic, readonly) NSArray<Player*>* players;

//
// Construct from parsed JSON object.
// - json: dictionary containing "players" array. Other fields are ignored.
// - url: base URL for any relative URLs found in the JSON.
// - error: optional output parameter in case of error.
//
- (instancetype)initWithJson:(NSDictionary*)json url:(NSURL*)url error:(NSError**)error;

//
// Construct from raw JSON data.
// - data: byte array of player data in JSON format.
// - url: base URL for any relative URLs found in the JSON.
// - error: optional output parameter in case of error.
//
- (instancetype)initWithData:(NSData*)data url:(NSURL*)url error:(NSError**)error;

@end
