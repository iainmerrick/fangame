#import <Foundation/Foundation.h>

#import "Players.h"

typedef void (^LoadPlayersBlock)(Players*);

//
// Singleton holding the Players object used by the app.
// By default we'll load a fixed URL, but tests can override this.
//
@interface SharedPlayers : NSObject

+ (void)load:(LoadPlayersBlock)completion;

@end

@interface SharedPlayers (TestHelpers)

+ (void)setUrl:(NSURL*)url;

@end
