//
//  RemoteSequenceTextField.h
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "HIDRemote.h"
#import "NSMutableArray+RemoteSequence.h"


@interface RemoteSequenceTextField : NSTextField <NSTextFieldDelegate, HIDRemoteDelegate>
{
    NSObject<HIDRemoteDelegate> * previousRemoteDelegate;
    
}
@property (strong) NSMutableArray* remoteSequence;
@end
