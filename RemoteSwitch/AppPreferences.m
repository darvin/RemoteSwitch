//
//  AppPreferences.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppPreferences.h"
#import "RemoteSequence.h"
@implementation AppPreferences
@synthesize toggleSequence, enableSequence, disableSequence;

-(id) init {
    if (self=[super init]) {
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        
        if (standardUserDefaults) {
            NSArray *val = [standardUserDefaults objectForKey:@"ToggleSequence"];
            if (!val)
                val = [NSArray arrayWithObjects:
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       nil];
            self.toggleSequence = [RemoteSequence sequenceFromUserDefaultsArray: val];
            
            
            val = [standardUserDefaults objectForKey:@"EnableSequence"];
            if (!val)
                val = [NSArray arrayWithObjects:
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       nil];
            self.enableSequence = [RemoteSequence sequenceFromUserDefaultsArray: val];
            
            val = [standardUserDefaults objectForKey:@"DisableSequence"];
            if (!val)
                val = [NSArray arrayWithObjects:
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       [NSNumber numberWithInt:kHIDRemoteButtonCodeMenu], 
                       nil];
            self.disableSequence = [RemoteSequence sequenceFromUserDefaultsArray: val];

        }
        
        
    }
    return self;
}


+(AppPreferences*) sharedAppPreferences {
    static AppPreferences* prefs = nil;
    if (!prefs)
    {
        prefs = [[AppPreferences alloc] init];
    }
    return prefs;
}

-(void) save {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if (standardUserDefaults) {
		[standardUserDefaults setObject:self.toggleSequence.sequence forKey:@"ToggleSequence"];
		[standardUserDefaults setObject:self.enableSequence.sequence forKey:@"EnableSequence"];
		[standardUserDefaults setObject:self.disableSequence.sequence forKey:@"DisableSequence"];
		[standardUserDefaults synchronize];
	}
}


@end
