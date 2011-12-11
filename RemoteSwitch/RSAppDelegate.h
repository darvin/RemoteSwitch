//
//  RSAppDelegate.h
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HIDRemote.h"

#define kMaxButtonSequenceLength 10
#define kSecondsBetweenButtons 3

@interface RSAppDelegate : NSObject <NSApplicationDelegate, HIDRemoteDelegate>
{
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
    NSMutableArray * pressedButtons;
    NSArray *buttonSequence;
    IBOutlet NSMenuItem *remoteMenuItem;
    CFAbsoluteTime lastTimeButtonPressed;
    
    NSImage *enabledImage;
    NSImage *disabledImage;
    
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic) BOOL remoteEnabled;
- (IBAction)toggleRemote:(id)sender;

@end
