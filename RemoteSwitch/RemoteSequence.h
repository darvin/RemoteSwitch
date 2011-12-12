//
//  NSMutableArray+RemoteSequence.h
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HIDRemote.h"


#define kMaxButtonSequenceLength 10


@interface RemoteSequence : NSObject
{
    NSMutableArray * _sequence;
}
+(RemoteSequence*) sequenceFromUserDefaultsArray:(NSArray*)array;
-(id) initWithArray:(NSArray*)array;

-(void) addButtonCode:(HIDRemoteButtonCode)buttonCode;
-(void) removeAllObjects;
-(BOOL) isSequenceOnEndOfSequence:(RemoteSequence*) sequence;
-(NSUInteger) count;
@property (readonly) NSMutableArray* sequence;
@end
