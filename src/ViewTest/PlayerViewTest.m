#import <XCTest/XCTest.h>

#import "PlayerView.h"
#import "Players.h"

@interface PlayerViewTest : XCTestCase <PlayerViewDelegate>

@end

@implementation PlayerViewTest
{
	NSBundle* _bundle;
	Players* _players;
	PlayerView* _view;
	void (^_didLoadImage)(PlayerViewTest* self);
}

- (void)setUp
{
	[super setUp];

	_bundle = [NSBundle bundleForClass:self.class];

	NSURL* url = [_bundle URLForResource:@"TestData/Players" withExtension:@"json"];
	NSData* data = [NSData dataWithContentsOfURL:url];
	_players = [[Players alloc] initWithData:data url:url error:NULL];

	_view = [[PlayerView alloc] initWithFrame:CGRectZero];
	_view.delegate = self;
}

- (void)playerViewImageLoaded:(PlayerView*)view
{
	XCTAssertEqual(view, _view);
	_didLoadImage(self);
}

- (void)playerViewImageFailed:(PlayerView*)view error:(NSError*)error
{
	XCTFail(@"playerViewImageFailed: %@", error);
}

- (void)testSetPlayer
{
	Player* a = _players.players[0];
	_view.player = a;

	XCTAssertEqual(_view.player, a);
	XCTAssertEqualObjects(_view.label.text, @"A 1");

	XCTestExpectation* expectation = [self expectationWithDescription:@"playerViewImageLoaded"];
	expectation.assertForOverFulfill = YES;

	_didLoadImage = ^(PlayerViewTest* self) {
		UIImage* image = self->_view.imageView.image;
		XCTAssertTrue(CGSizeEqualToSize(image.size, a.imageSize));
		[expectation fulfill];
	};

	[self waitForExpectationsWithTimeout:1 handler:NULL];
}

- (void)testSetPlayerMultipleTimes
{
	// Each setPlayer: fires off an asynchronous download for the image,
	// so if we call it multiple times, there's a risk of the callbacks
	// stepping on each others' toes -- e.g. we could use the wrong image.

	Player* a = _players.players[0];
	Player* b = _players.players[1];
	Player* c = _players.players[2];

	_view.player = a;
	_view.player = b;
	_view.player = c;

	UIImage* b_png =
	    [UIImage imageNamed:@"TestData/B.png" inBundle:_bundle compatibleWithTraitCollection:nil];
	UIImage* c_png =
	    [UIImage imageNamed:@"TestData/C.png" inBundle:_bundle compatibleWithTraitCollection:nil];

	XCTestExpectation* expectation = [self expectationWithDescription:@"playerViewImageLoaded"];
	expectation.assertForOverFulfill = YES;

	// We expect exactly one callback, with the image for 'c'.
	// If the callbacks for 'a' and 'b' arrive they should be silently ignored.
	_didLoadImage = ^(PlayerViewTest* self) {
		// How do we know we got the right image? Let's just convert them to PNGs
		// (which should be identical). Kind of overkill, but it's a one-liner!
		UIImage* image = self->_view.imageView.image;
		XCTAssertEqualObjects(UIImagePNGRepresentation(image), UIImagePNGRepresentation(c_png));

		self->_view.player = a;
		self->_view.player = b;

		// Now we expect to get 'b', and only b.
		self->_didLoadImage = ^(PlayerViewTest* self) {
			UIImage* image = self->_view.imageView.image;
			XCTAssertEqualObjects(UIImagePNGRepresentation(image), UIImagePNGRepresentation(b_png));
			[expectation fulfill];
		};
	};

	[self waitForExpectationsWithTimeout:0.1 handler:nil];
}

@end
