//
//  FileLoaderTest.m
//  ModelTest
//
//  Created by Iain Merrick on 16/05/2018.
//  Copyright © 2018 Iain Merrick. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FileLoader.h"

@interface FileLoaderTest : XCTestCase

@end

static NSBundle* _bundle;
static NSData* _a_png;
static NSData* _b_png;

@implementation FileLoaderTest

+ (void)setUp
{
	_bundle = [NSBundle bundleForClass:self.class];
	_a_png = [NSData dataWithContentsOfFile:[_bundle pathForResource:@"Data/A"
															  ofType:@"png"]];
	_b_png = [NSData dataWithContentsOfFile:[_bundle pathForResource:@"Data/B"
															  ofType:@"png"]];
}

- (void)setUp
{
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}

- (void)testLoad
{
	id<Loader> loader = [FileLoader loaderWithPath:_bundle.resourcePath];

	XCTestExpectation* expect = [self expectationWithDescription:@"Load A.png"];

	[loader loadUrl:@"Data/A.png"
		 completion:^(NSData* data, id<Loader> subloader, NSError* err) {
			 if (err) XCTFail(@"%@", err);
			 XCTAssertEqualObjects(data, _a_png);
			 [expect fulfill];
		 }];

	[self waitForExpectationsWithTimeout:0.1
								 handler:^(NSError* err) {
									 if (err) XCTFail(@"%@", err);
								 }];
}

- (void)testLoadRelative
{
	id<Loader> loader = [FileLoader loaderWithPath:_bundle.resourcePath];

	XCTestExpectation* expect = [self expectationWithDescription:@"Load A.png"];

	[loader loadUrl:@"Data/A.png"
		 completion:^(NSData* data, id<Loader> subloader, NSError* err) {
			 if (err) XCTFail(@"%@", err);
			 [subloader
					loadUrl:@"B.png"
				 completion:^(NSData* data, id<Loader> subloader, NSError* err) {
					 if (err) XCTFail(@"%@", err);
					 XCTAssertEqualObjects(data, _b_png);
					 [expect fulfill];
				 }];
		 }];

	[self waitForExpectationsWithTimeout:0.1
								 handler:^(NSError* err) {
									 if (err) XCTFail("%@", err);
								 }];
}

@end
