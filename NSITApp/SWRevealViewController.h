/*
 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

 Early code inspired on a similar class by Philip Kluz (Philip.Kluz@zuui.org)
*/

#import <UIKit/UIKit.h>

@class SWRevealViewController;
@protocol SWRevealViewControllerDelegate;

#pragma mark - SWRevealViewController Class

typedef NS_ENUM( NSInteger, FrontViewPosition)
{
       FrontViewPositionLeftSideMostRemoved,
    FrontViewPositionLeftSideMost,
    FrontViewPositionLeftSide,
	FrontViewPositionLeft,
	FrontViewPositionRight,
	FrontViewPositionRightMost,
    FrontViewPositionRightMostRemoved,
};
typedef NS_ENUM(NSInteger, SWRevealToggleAnimationType)
{
    SWRevealToggleAnimationTypeSpring,    // <- produces a spring based animation
    SWRevealToggleAnimationTypeEaseOut,   // <- produces an ease out curve animation
};

@interface SWRevealViewController : UIViewController

- (id)initWithRearViewController:(UIViewController *)rearViewController frontViewController:(UIViewController *)frontViewController;

@property (nonatomic) UIViewController *rearViewController;
- (void)setRearViewController:(UIViewController *)rearViewController animated:(BOOL)animated;

@property (nonatomic) UIViewController *rightViewController;
- (void)setRightViewController:(UIViewController *)rightViewController animated:(BOOL)animated;

@property (nonatomic) UIViewController *frontViewController;
- (void)setFrontViewController:(UIViewController *)frontViewController animated:(BOOL)animated;

- (void)pushFrontViewController:(UIViewController *)frontViewController animated:(BOOL)animated;

@property (nonatomic) FrontViewPosition frontViewPosition;
- (void)setFrontViewPosition:(FrontViewPosition)frontViewPosition animated:(BOOL)animated;

- (IBAction)revealToggle:(id)sender;
- (IBAction)rightRevealToggle:(id)sender; // <-- simetric implementation of the above for the rightViewController

- (void)revealToggleAnimated:(BOOL)animated;
- (void)rightRevealToggleAnimated:(BOOL)animated; // <-- simetric implementation of the above for the rightViewController

- (UIPanGestureRecognizer*)panGestureRecognizer;

- (UITapGestureRecognizer*)tapGestureRecognizer;

@property (nonatomic) CGFloat rearViewRevealWidth;
@property (nonatomic) CGFloat rightViewRevealWidth; // <-- simetric implementation of the above for the rightViewController

@property (nonatomic) CGFloat rearViewRevealOverdraw;
@property (nonatomic) CGFloat rightViewRevealOverdraw;
@property (nonatomic) CGFloat rearViewRevealDisplacement;
@property (nonatomic) CGFloat rightViewRevealDisplacement;  // <-- simetric implementation of the above for the rightViewController

@property (nonatomic) CGFloat draggableBorderWidth;

// If YES (the default) the controller will bounce to the Left position when dragging further than 'rearViewRevealWidth'
@property (nonatomic) BOOL bounceBackOnOverdraw;
@property (nonatomic) BOOL bounceBackOnLeftOverdraw;  // <-- simetric implementation of the above for the rightViewController

@property (nonatomic) BOOL stableDragOnOverdraw;
@property (nonatomic) BOOL stableDragOnLeftOverdraw; // <-- simetric implementation of the above for the rightViewController

@property (nonatomic) BOOL presentFrontViewHierarchically;
@property (nonatomic) CGFloat quickFlickVelocity;

@property (nonatomic) NSTimeInterval toggleAnimationDuration;

@property (nonatomic) SWRevealToggleAnimationType toggleAnimationType;

@property (nonatomic) CGFloat springDampingRatio;

@property (nonatomic) NSTimeInterval replaceViewAnimationDuration;

@property (nonatomic) CGFloat frontViewShadowRadius;

@property (nonatomic) CGSize frontViewShadowOffset;

@property (nonatomic) CGFloat frontViewShadowOpacity;

@property (nonatomic) UIColor *frontViewShadowColor;

@property (nonatomic) BOOL clipsViewsToBounds;

@property (nonatomic) BOOL extendsPointInsideHit;
// Delegate
@property (nonatomic,weak) id<SWRevealViewControllerDelegate> delegate;

@end
typedef enum
{
    SWRevealControllerOperationNone,
    SWRevealControllerOperationReplaceRearController,
    SWRevealControllerOperationReplaceFrontController,
    SWRevealControllerOperationReplaceRightController,
    
} SWRevealControllerOperation;


@protocol SWRevealViewControllerDelegate<NSObject>

@optional
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position;
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position;

// This will be called inside the reveal animation, thus you can use it to place your own code that will be animated in sync
- (void)revealController:(SWRevealViewController *)revealController animateToPosition:(FrontViewPosition)position;

// Implement this to return NO when you want the pan gesture recognizer to be ignored
- (BOOL)revealControllerPanGestureShouldBegin:(SWRevealViewController *)revealController;

// Implement this to return NO when you want the tap gesture recognizer to be ignored
- (BOOL)revealControllerTapGestureShouldBegin:(SWRevealViewController *)revealController;

// Implement this to return YES if you want other gesture recognizer to share touch events with the pan gesture
- (BOOL)revealController:(SWRevealViewController *)revealController
    panGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
- (BOOL)revealController:(SWRevealViewController *)revealController
    tapGestureRecognizerShouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

// Called when the gestureRecognizer began and ended
- (void)revealControllerPanGestureBegan:(SWRevealViewController *)revealController;
- (void)revealControllerPanGestureEnded:(SWRevealViewController *)revealController;

- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress overProgress:(CGFloat)overProgress;
- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress overProgress:(CGFloat)overProgress;
- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress overProgress:(CGFloat)overProgress;

- (void)revealController:(SWRevealViewController *)revealController willAddViewController:(UIViewController *)viewController
    forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated;
- (void)revealController:(SWRevealViewController *)revealController didAddViewController:(UIViewController *)viewController
    forOperation:(SWRevealControllerOperation)operation animated:(BOOL)animated;

- (id<UIViewControllerAnimatedTransitioning>)revealController:(SWRevealViewController *)revealController
    animationControllerForOperation:(SWRevealControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC;

// DEPRECATED - The following delegate methods will be removed some time in the future
- (void)revealController:(SWRevealViewController *)revealController panGestureBeganFromLocation:(CGFloat)location progress:(CGFloat)progress; // (DEPRECATED)
- (void)revealController:(SWRevealViewController *)revealController panGestureMovedToLocation:(CGFloat)location progress:(CGFloat)progress; // (DEPRECATED)
- (void)revealController:(SWRevealViewController *)revealController panGestureEndedToLocation:(CGFloat)location progress:(CGFloat)progress; // (DEPRECATED)
@end

@interface UIViewController(SWRevealViewController)

- (SWRevealViewController*)revealViewController;

@end
extern NSString* const SWSegueRearIdentifier;  // this is @"sw_rear"
extern NSString* const SWSegueFrontIdentifier; // this is @"sw_front"
extern NSString* const SWSegueRightIdentifier; // this is @"sw_right"

/* This will allow the class to be defined on a storyboard */

// Use this along with one of the above segue identifiers to segue to the initial state
@interface SWRevealViewControllerSegueSetController : UIStoryboardSegue
@end

// Use this to push a view controller
@interface SWRevealViewControllerSeguePushController : UIStoryboardSegue
@end
