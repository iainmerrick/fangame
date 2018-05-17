#pragma once

#import <Foundation/Foundation.h>

#import "Loader.h"

@interface FileLoader : NSObject <Loader>

@property (readonly) NSString* path;

- (instancetype)initWithPath:(NSString*)path;

@end
