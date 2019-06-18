#include "Rik+Button.h"
#include "RikWindowButton.h"
#include <AppKit/NSAnimation.h>
#import <AppKit/NSWindow.h>
#import <AppKit/NSImage.h>
#import "GNUstepGUI/GSTheme.h"

@interface DefaultButtonAnimation: NSAnimation
{
  NSButtonCell * defaultButtonCell;
  BOOL reverse;
}

@end

@implementation DefaultButtonAnimation

- (BOOL) reverse {
  return reverse;
}
- (void) setReverse: (BOOL) aReverse {
  reverse = aReverse;
}


- (NSButtonCell *) defautButtonCell {
  return defaultButtonCell;
}

- (void) setDefaultButtonCell: (NSButtonCell *) aDefaultButtonCell {
  if (aDefaultButtonCell != defaultButtonCell) {
    [aDefaultButtonCell retain];
    [defaultButtonCell release];
    defaultButtonCell = aDefaultButtonCell;
  }
}
  

- (void)setCurrentProgress:(NSAnimationProgress)progress
{
  /*  [super setCurrentProgress: progress];
  if(defaultButtonCell)
    {
        if(reverse)
        {
          //defaultButtonCell.pulseProgress = [NSNumber numberWithFloat: 1.0 - progress];
	  [defaultButtonCell setPulseProgress: [NSNumber numberWithFloat: 1.0 - progress]];
        }else{
          //defaultButtonCell.pulseProgress = [NSNumber numberWithFloat: progress];
	  [defaultButtonCell setPulseProgress: [NSNumber numberWithFloat: progress]];
        }
        [[defaultButtonCell controlView] setNeedsDisplay: YES];
    }
  if (progress >= 1.0)
  {
    reverse = !reverse;
    [self startAnimation];
    }*/
}

@end

@interface DefaultButtonAnimationController : NSObject

{
  /*DefaultButtonAnimation * animation;*/
    NSButtonCell * buttoncell;
}

@property (retain) NSButtonCell * buttoncell;
/*@property (retain) NSAnimation * animation;*/

@end
@implementation DefaultButtonAnimationController
@synthesize buttoncell;
/*@synthesize animation;*/
- (id) initWithButtonCell: (NSButtonCell*) cell
{
  if ((self = [super init])) {
    buttoncell = cell;
  }
  return self;
}
- (void) startPulse
{
  /* [self startPulse: NO];*/
}
- (void) startPulse: (BOOL) reverse
{/*
  animation = [[DefaultButtonAnimation alloc] initWithDuration:0.7
                                animationCurve:NSAnimationEaseInOut];
  //animation.reverse = reverse;
  [animation setReverse: reverse];
  [animation addProgressMark: 1.0];
  [animation setDelegate: self];
  [animation setFrameRate:30.0];
  [animation setAnimationBlockingMode:NSAnimationNonblocking];
  //animation.defaultButtonCell = buttoncell;
  [animation setDefaultButtonCell: buttoncell];
  [animation startAnimation];*/
}
- (void)animation:(NSAnimation *)a
            didReachProgressMark:(NSAnimationProgress)progress
{/*
  //[animation stopAnimation];
  //[self startPulse: !animation.reverse];*/
}
@end
@implementation NSWindow(RikTheme)

+ (NSButton *) standardWindowButton: (NSWindowButton)button
                       forStyleMask: (NSUInteger) mask
{
  RikWindowButton *newButton;

  switch (button)
    {
      case NSWindowCloseButton:
        newButton = [[RikWindowButton alloc] init];
        [newButton setBaseColor: [NSColor colorWithCalibratedRed: 0.8 green: 0.0 blue: 0.0 alpha: 1]];
        [newButton setImage: [NSImage imageNamed: @"common_Close"]];
        [newButton setAlternateImage: [NSImage imageNamed: @"common_CloseH"]];
        [newButton setAction: @selector(performClose:)];
        break;
      case NSWindowMiniaturizeButton:
        newButton = [[RikWindowButton alloc] init];
        [newButton setBaseColor: [NSColor colorWithCalibratedRed: 0.9 green: 0.9 blue: 0.0 alpha: 1]];
        [newButton setImage: [NSImage imageNamed: @"common_Miniaturize"]];
        [newButton setAlternateImage: [NSImage imageNamed: @"common_MiniaturizeH"]];
        [newButton setAction: @selector(miniaturize:)];
        break;

      case NSWindowZoomButton:
        // FIXME
        newButton = [[RikWindowButton alloc] init];
        [newButton setBaseColor: [NSColor colorWithCalibratedRed: 0.322 green: 0.778 blue: 0.244 alpha: 1]];
        [newButton setAction: @selector(zoom:)];
        break;

      case NSWindowToolbarButton:
        // FIXME
        newButton = [[RikWindowButton alloc] init];
        [newButton setAction: @selector(toggleToolbarShown:)];
        break;
      case NSWindowDocumentIconButton:
      default:
        newButton = [[RikWindowButton alloc] init];
        // FIXME
        break;
    }

  [newButton setRefusesFirstResponder: YES];
  [newButton setButtonType: NSMomentaryChangeButton];
  [newButton setImagePosition: NSImageOnly];
  [newButton setBordered: YES];
  [newButton setTag: button];
  return AUTORELEASE(newButton);
}
- (void) setDefaultButtonCell: (NSButtonCell *)aCell
{
  ASSIGN(_defaultButtonCell, aCell);
  _f.default_button_cell_key_disabled = NO;

  [aCell setKeyEquivalent: @"\r"];
  [aCell setKeyEquivalentModifierMask: 0];
  [aCell setIsDefaultButton: [NSNumber numberWithBool: YES]];
  //DefaultButtonAnimationController * animationcontroller = [[DefaultButtonAnimationController alloc] initWithButtonCell: aCell];
  // [animationcontroller startPulse];
}
- (void) animateDefaultButton: (id)sender
{
}

@end

