#pragma once

#import <Foundation/Foundation.h>

#import "Loader.h"

@interface FileLoader : NSObject <Loader>

@property (readonly) NSString* path;

+ (instancetype)loaderWithPath:(NSString*)path;

@end
