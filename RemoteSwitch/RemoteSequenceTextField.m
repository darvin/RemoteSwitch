//
//  RemoteSequenceTextField.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteSequenceTextField.h"
#import "HIDRemote.h"
#import "NSMutableArray+RemoteSequence.h"

@implementation RemoteSequenceTextField
@synthesize remoteSequence;
-(void)awakeFromNib {
    self.delegate = self;
    self.remoteSequence = [[NSMutableArray alloc] init];
}


-(void) controlTextDidEndEditing:(NSNotification *)obj {
    [[HIDRemote sharedHIDRemote] stopRemoteControl];
    [[HIDRemote sharedHIDRemote] setDelegate:previousRemoteDelegate];

}

-(BOOL) becomeFirstResponder {
    
    previousRemoteDelegate = [[HIDRemote sharedHIDRemote] delegate];
    [[HIDRemote sharedHIDRemote] setDelegate:self];
    if ([[HIDRemote sharedHIDRemote] isStarted])
        [[HIDRemote sharedHIDRemote] stopRemoteControl];
    
    [[HIDRemote sharedHIDRemote] startRemoteControl:kHIDRemoteModeExclusiveAuto];

    
    
    return [super becomeFirstResponder];
}


-(void) refreshSequence {
    [self setStringValue:[self.remoteSequence humanReadable]];
}

- (void)hidRemote:(HIDRemote *)hidRemote				// The instance of HIDRemote sending this
  eventWithButton:(HIDRemoteButtonCode)buttonCode			// Event for the button specified by code
        isPressed:(BOOL)isPressed					// The button was pressed (YES) / released (NO)
fromHardwareWithAttributes:(NSMutableDictionary *)attributes;	// Information on the device this event comes from
{
    if (!isPressed) {
        NSLog(@"%@", self.remoteSequence);
        [self.remoteSequence addButtonCode:buttonCode];
        [self refreshSequence];
    }
    
}


@end
