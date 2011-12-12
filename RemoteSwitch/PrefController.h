//
//  PrefController.h
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RemoteSequenceTextField.h"

@class PrefController;

@protocol PrefControllerDelegate <NSObject>
@optional
-(void) prefControllerClosed:(PrefController*)prefController;

@end

@interface PrefController : NSWindowController <NSWindowDelegate> {
}
+(PrefController*) sharedPrefController;

@property (weak) id<PrefControllerDelegate> delegate;
@property (weak) IBOutlet RemoteSequenceTextField *toggleField;
@property (weak) IBOutlet RemoteSequenceTextField *enableField;
@property (weak) IBOutlet RemoteSequenceTextField *disableField;


@end
