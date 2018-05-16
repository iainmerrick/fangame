#import <Foundation/Foundation.h>

//
// Information about a single player.
//
@interface Player : NSObject

@property (readonly, nonnull) NSString* firstName;
@property (readonly, nonnull) NSString* lastName;
@property (readonly) CGFloat fppg;
@property (readonly) CGSize imageSize;

// TODO: 'image' property will have a couple of wrinkles:
// - iOS and macOS have different image classes, doh
// - Image will need to be loaded asynchronously

+ (instancetype)loadJsonObject:(NSDictionary*)json;

@end
