//
//  RSAppDelegate.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RSAppDelegate.h"
#import "HIDRemote.h"

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

-(void)awakeFromNib{

    pressedButtons = [NSMutableArray array];
    buttonSequence = [NSArray arrayWithObjects:
                      [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                      [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                      [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                      
                      nil];
    
    disabledImage = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]
                                                             pathForResource:@"disabled" ofType:@"png"]];
    enabledImage = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]
                                                            pathForResource:@"enabled" ofType:@"png"]];
    
    
    
    
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
        self.remoteEnabled = NO;

    }
    

    
}

- (IBAction)toggleRemote:(id)sender
{
    self.remoteEnabled = !self.remoteEnabled;
}



#pragma mark -- Handle remote control events --
- (void)hidRemote:(HIDRemote *)hidRemote eventWithButton:(HIDRemoteButtonCode)buttonCode isPressed:(BOOL)isPressed fromHardwareWithAttributes:(NSMutableDictionary *)attributes
{
    
//    
//    
//	NSString *buttonName = nil;
//    
//	switch (buttonCode)
//	{
//		case kHIDRemoteButtonCodeUp:
//			buttonName = @"Up";
//            break;
//            
//		case kHIDRemoteButtonCodeUpHold:
//			buttonName = @"Up (hold)";
//            break;
//            
//		case kHIDRemoteButtonCodeDown:
//			buttonName = @"Down";
//            break;
//            
//		case kHIDRemoteButtonCodeDownHold:
//			buttonName = @"Down (hold)";
//            break;
//            
//		case kHIDRemoteButtonCodeLeft:
//			buttonName = @"Left";
//            break;
//            
//		case kHIDRemoteButtonCodeLeftHold:
//			buttonName = @"Left (hold)";
//            break;
//            
//		case kHIDRemoteButtonCodeRight:
//			buttonName = @"Right";
//            break;
//            
//		case kHIDRemoteButtonCodeRightHold:
//			buttonName = @"Right (hold)";
//            break;
//            
//		case kHIDRemoteButtonCodeCenter:
//			buttonName = @"Center";
//            break;
//            
//		case kHIDRemoteButtonCodeCenterHold:
//			buttonName = @"Center (hold)";
//            break;
//            
//		case kHIDRemoteButtonCodeMenu:
//			buttonName = @"Menu";
//            break;
//            
//		case kHIDRemoteButtonCodeMenuHold:
//			buttonName = @"Menu (hold)";
//            break;
//            
//		case kHIDRemoteButtonCodePlay:
//			buttonName = @"Play (Alu Remote!)";
//            break;
//            
//		case kHIDRemoteButtonCodePlayHold:
//			buttonName = @"Play (Alu Remote!) (hold)";
//            break;
//	}
	
	if (isPressed)
	{
	}
	else
	{
        if (lastTimeButtonPressed  < (CFAbsoluteTimeGetCurrent() - kSecondsBetweenButtons)) {
            [pressedButtons removeAllObjects];
        }
        
        
        [pressedButtons addObject: [NSNumber numberWithInt:buttonCode]];
        
        
        if ([pressedButtons count]>=[buttonSequence count]) {
            NSArray * slice = [pressedButtons subarrayWithRange:
                           (NSRange){[pressedButtons count]-[buttonSequence count], [buttonSequence count]}];
            if ([slice isEqualToArray:buttonSequence]) {
                [pressedButtons removeAllObjects];
                [self performSelector:@selector(toggleRemote:)withObject:self afterDelay:0.01];
            }
        }
        
        lastTimeButtonPressed =CFAbsoluteTimeGetCurrent();

	}
    if ([pressedButtons count]>kMaxButtonSequenceLength) {
        [ pressedButtons removeObjectAtIndex:0 ];

    }
    
}



@end
