#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

//
// Information about a single player.
//
@interface Player : NSObject

@property (readonly, nonnull) NSString* firstName;
@property (readonly, nonnull) NSString* lastName;
@property (readonly) CGFloat fppg;
@property (readonly) CGSize imageSize;
@property (readonly) NSURL* imageUrl;

//
// Constructor.
// - json: dictionary containing player record
// - url: base URL for relative image URLs in the JSON.
//
- (instancetype)initWithJson:(NSDictionary*)json url:(NSURL*)url;

@end
