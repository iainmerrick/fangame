#import <XCTest/XCTest.h>

#import "PlayerView.h"
#import "Players.h"

@interface PlayerViewTest : XCTestCase <PlayerViewDelegate>

@end

@implementation PlayerViewTest
{
	PlayerView* _view;
	void (^_didLoadImage)(PlayerViewTest* self);
}

- (void)setUp
{
	[super setUp];
	self.continueAfterFailure = NO;
	[[[XCUIApplication alloc] init] launch];

	_view = [[PlayerView alloc] initWithFrame:CGRectZero];
	_view.delegate = self;
}

- (void)playerViewImageLoaded:(PlayerView*)view
{
	XCTAssertEqual(view, _view);
	_didLoadImage(self);
}

- (void)playerViewImageFailed:(PlayerView*)view error:(NSError*)error { XCTFail(@"%@", error); }

- (void)testLoadPlayer
{
	NSBundle* bundle = [NSBundle bundleForClass:self.class];
	NSURL* url = [bundle URLForResource:@"TestData/Players" withExtension:@"json"];
	NSData* data = [NSData dataWithContentsOfURL:url];
	Players* players = [[Players alloc] initWithData:data url:url error:NULL];
	Player* a = players.players[0];

	XCTestExpectation* expectation = [self expectationWithDescription:@"playerViewImageLoaded"];
	_didLoadImage = ^(PlayerViewTest* self) {
		UIImage* image = self->_view.imageView.image;
		XCTAssertTrue(CGSizeEqualToSize(image.size, a.imageSize));
		[expectation fulfill];
	};

	_view.player = a;
	XCTAssertEqualObjects(_view.label.text, @"A 1");
	[self waitForExpectationsWithTimeout:1 handler:NULL];
}

@end
