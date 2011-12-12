//
//  RSAppDelegate.h
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HIDRemote.h"
#import "PrefController.h"
#import "RemoteSequence.h"

#define kSecondsBetweenButtons 3
#define kDelayBeforeSwitch 0.001

@interface RSAppDelegate : NSObject <NSApplicationDelegate, HIDRemoteDelegate, PrefControllerDelegate>
{
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
    NSStatusItem * statusItem;
    RemoteSequence * pressedButtons;
    IBOutlet NSMenuItem *remoteMenuItem;
    CFAbsoluteTime lastTimeButtonPressed;
    
    NSImage *enabledImage;
    NSImage *disabledImage;
    NSAttributedString *enabledTitle;
    NSAttributedString *disabledTitle;
    
    
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic) BOOL remoteEnabled;
- (IBAction)toggleRemote:(id)sender;

@end
