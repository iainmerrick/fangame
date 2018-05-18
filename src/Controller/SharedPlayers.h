#import <Foundation/Foundation.h>

#import "Players.h"

typedef void (^LoadPlayersBlock)(Players*);

//
// Singleton holding the Players object used by the app.
//
@interface SharedPlayers : NSObject

+ (void)load:(LoadPlayersBlock)completion;

@end

// By default we'll load a fixed URL, but tests can override
// this by setting this environment variable.
extern const NSString* const SHARED_PLAYERS_URL;

@interface SharedPlayers (TestHelpers)

// Zero out the singleton (if any).
// Note that any existing references won't be cleared.
+ (void)reset;

@end
