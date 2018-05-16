#pragma once

//
// An object that can asynchronously load resources (e.g. JSON files and images).
//
@protocol Loader;

//
// Prototype for loader callback function.
// - data: contents of the requested URL
// - subloader: a Loader instance that can be used to load relative URLs
// - error: NULL on success, an NSError on failure
//
typedef void (^LoadCompletionBlock)(
	NSData* data, id<Loader> subloader, NSError* error);

@protocol Loader

//
// Load the specified URL. Invoke the given callback on completion.
// The callback could be executed immediately (before this call returns)
// or asynchronously.
//
- (void)loadUrl:(NSString*)url completion:(LoadCompletionBlock)block;

@end
