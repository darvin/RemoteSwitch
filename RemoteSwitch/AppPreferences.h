//
//  AppPreferences.h
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteSequence.h"
@interface AppPreferences : NSObject
@property (strong) RemoteSequence* toggleSequence;
@property (strong) RemoteSequence* enableSequence;
@property (strong) RemoteSequence* disableSequence;
+(AppPreferences*) sharedAppPreferences;
-(void) save;
@end
