//
//  NSMutableArray+RemoteSequence.h
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HIDRemote.h"
@interface NSMutableArray (RemoteSequence)
-(void) addButtonCode:(HIDRemoteButtonCode)buttonCode;
-(NSString*) humanReadable;
@end
