//
//  NSMutableArray+RemoteSequence.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteSequence.h"
#import "HIDRemote.h"

@implementation RemoteSequence
@synthesize sequence = _sequence;

+(RemoteSequence*) sequenceFromUserDefaultsArray:(NSArray*)array {
    return [[self alloc] initWithArray:array];
}

-(id) initWithArray:(NSArray*)array {
    if (self=[super init]) {
        if (!array) {
            _sequence = [NSMutableArray array];
        } else {
            _sequence = [NSMutableArray arrayWithArray:array];
        }
    }
    return self;
}

-(id) init {
    return [self initWithArray:nil];
}

-(void) addButtonCode:(HIDRemoteButtonCode)buttonCode {
    [_sequence addObject:[NSNumber numberWithInt:buttonCode]];
    
    
    if ([_sequence count]>kMaxButtonSequenceLength) {
        [_sequence removeObjectAtIndex:0 ];
        
    }
    
}
-(void) removeAllObjects {
    [_sequence removeAllObjects];
}
-(NSString*) description {
    NSMutableString* result = [NSMutableString string];
    
    NSString *buttonName = nil;
    
    for (NSNumber * item in _sequence) {
        
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
-(NSUInteger) count {
    return [_sequence count];
}

-(BOOL) isSequenceOnEndOfSequence:(RemoteSequence*) sequence {
    //        if ([pressedButtons count]>=[buttonSequence count]) {
    //            NSArray * slice = [pressedButtons subarrayWithRange:
    //                           (NSRange){[pressedButtons count]-[buttonSequence count], [buttonSequence count]}];
    //            if ([slice isEqualToArray:buttonSequence]) {
    //                [pressedButtons removeAllObjects];
    //                [self performSelector:@selector(toggleRemote:)withObject:self afterDelay:0.01];
    //            }
    //        }
    BOOL result = NO;
    
    if ([sequence count]>=[self count]) {
        NSArray * slice = [sequence.sequence subarrayWithRange:
                (NSRange){[sequence count]-[self count], [self count]}];
        NSLog(@"slice %@ \n arr %@", slice, _sequence);
        return ([slice isEqualToArray:_sequence]);
    }
    
    return result;
}

@end
