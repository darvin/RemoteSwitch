//
//  RSAppDelegate.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSAppDelegate.h"
#import "HIDRemote.h"
#import "PrefController.h"
#import "AppPreferences.h"
#import "RemoteSequence.h"
#import "NSImage+FromGlyph.h"
@interface RSAppDelegate() 
-(void) enableRemote;
-(void) disableRemote;
@end

@implementation RSAppDelegate

@synthesize window = _window, remoteEnabled;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

}

-(void) setRemoteEnabled:(BOOL)enabled {
    if ([[HIDRemote sharedHIDRemote] isStarted])
        [[HIDRemote sharedHIDRemote] stopRemoteControl];

    if(!enabled) {
        [[HIDRemote sharedHIDRemote] startRemoteControl:kHIDRemoteModeExclusiveAuto];
        [remoteMenuItem setState:NSOffState];
        [statusItem setImage:disabledImage];
    }
    else {
        [[HIDRemote sharedHIDRemote] startRemoteControl:kHIDRemoteModeShared];
        [remoteMenuItem setState:NSOnState];

        [statusItem setImage:enabledImage];
        
    }
    remoteEnabled = enabled;
}
-(void) enableRemote {
    self.remoteEnabled = YES;
}
-(void) disableRemote {
    self.remoteEnabled = NO;
}

-(void)awakeFromNib{

    pressedButtons = [[RemoteSequence alloc] init];

    
    disabledImage = [NSImage imageNamed:@"disabled"];
    enabledImage = [NSImage imageNamed:@"enabled"];
    
    
    
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setHighlightMode:YES];    
    
    if ([HIDRemote isCandelairInstallationRequiredForRemoteMode:kHIDRemoteModeExclusiveAuto])
    {
        // Candelair needs to be installed. Inform the user about it.
        NSLog(@"Candelair is needed! Exit");
    }	
    else
    {
        // Start using HIDRemote ..
        [[HIDRemote sharedHIDRemote] setDelegate:self];
        self.remoteEnabled = YES;

    }
    

    
}

- (IBAction)toggleRemote:(id)sender
{
    self.remoteEnabled = !self.remoteEnabled;
}

- (IBAction) openPreferences:(id)sender {
    [[HIDRemote sharedHIDRemote] setDelegate:nil];
    if ([[HIDRemote sharedHIDRemote] isStarted])
        [[HIDRemote sharedHIDRemote] stopRemoteControl];

    [PrefController sharedPrefController].delegate = self;
    [[PrefController sharedPrefController] showWindow:self];
    [[[PrefController sharedPrefController] window] orderFrontRegardless];
    

}

- (void) prefControllerClosed:(PrefController *)prefController{
    [HIDRemote sharedHIDRemote].delegate = self; 
    self.remoteEnabled = self.remoteEnabled;
}


#pragma mark -- Handle remote control events --
- (void)hidRemote:(HIDRemote *)hidRemote eventWithButton:(HIDRemoteButtonCode)buttonCode isPressed:(BOOL)isPressed fromHardwareWithAttributes:(NSMutableDictionary *)attributes
{
    	
	if (isPressed)
	{
	}
	else
	{
        if (lastTimeButtonPressed  < (CFAbsoluteTimeGetCurrent() - kSecondsBetweenButtons)) {
            [pressedButtons removeAllObjects];
        }
        
        
        [pressedButtons addButtonCode:buttonCode];
        
        

        
        AppPreferences* appPrefs = [AppPreferences sharedAppPreferences];
        
        if ([appPrefs.toggleSequence isSequenceOnEndOfSequence:pressedButtons]) {
                [pressedButtons removeAllObjects];
                [self performSelector:@selector(toggleRemote:)withObject:self afterDelay:kDelayBeforeSwitch];
        } else if ([appPrefs.enableSequence isSequenceOnEndOfSequence:pressedButtons]) {
            [pressedButtons removeAllObjects];
            [self performSelector:@selector(enableRemote)withObject:nil afterDelay:kDelayBeforeSwitch];
        } else if ([appPrefs.disableSequence isSequenceOnEndOfSequence:pressedButtons]) {
            [pressedButtons removeAllObjects];
            [self performSelector:@selector(disableRemote)withObject:nil afterDelay:kDelayBeforeSwitch];
        }
        
        lastTimeButtonPressed =CFAbsoluteTimeGetCurrent();

	}
    
}



@end
