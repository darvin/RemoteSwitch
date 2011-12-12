//
//  NSMutableArray+RemoteSequence.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+RemoteSequence.h"
#import "HIDRemote.h"

@implementation NSMutableArray (RemoteSequence)
-(void) addButtonCode:(HIDRemoteButtonCode)buttonCode {
    [self addObject:[NSNumber numberWithInt:buttonCode]];
}

-(NSString*) humanReadable {
    NSMutableString* result = [NSMutableString string];
    
    NSString *buttonName = nil;
    
    for (NSNumber * item in self) {
        
        switch ([item intValue])
        {
            case kHIDRemoteButtonCodeUp:
                buttonName = @"^";
                break;
                
            case kHIDRemoteButtonCodeUpHold:
                buttonName = @"^h";
                break;
                
            case kHIDRemoteButtonCodeDown:
                buttonName = @"/";
                break;
                
            case kHIDRemoteButtonCodeDownHold:
                buttonName = @"/h";
                break;
                
            case kHIDRemoteButtonCodeLeft:
                buttonName = @"<";
                break;
                
            case kHIDRemoteButtonCodeLeftHold:
                buttonName = @"<h";
                break;
                
            case kHIDRemoteButtonCodeRight:
                buttonName = @">";
                break;
                
            case kHIDRemoteButtonCodeRightHold:
                buttonName = @">h";
                break;
                
            case kHIDRemoteButtonCodeCenter:
                buttonName = @".";
                break;
                
            case kHIDRemoteButtonCodeCenterHold:
                buttonName = @".h";
                break;
                
            case kHIDRemoteButtonCodeMenu:
                buttonName = @"M";
                break;
                
            case kHIDRemoteButtonCodeMenuHold:
                buttonName = @"Mh";
                break;
                
            case kHIDRemoteButtonCodePlay:
                buttonName = @"P";
                break;
                
            case kHIDRemoteButtonCodePlayHold:
                buttonName = @"Ph";
                break;
        }
        [result appendString:buttonName];
        
    }
    return result;
}

@end
