//
//  PrefController.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PrefController.h"
#import "AppPreferences.h"
@implementation PrefController
@synthesize delegate, toggleField, enableField, disableField;

-(void) awakeFromNib {
//    NSDictionary *attributes = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                [NSFont fontWithName:@"Apple Symbols" size:12.0], NSFontAttributeName, nil];
//    
//    NSAttributedString* disabledTitle = [[NSAttributedString alloc] 
//                                         initWithString:@"\u5003"
//                                         attributes: attributes];
//    toggleField.font = [NSFont fontWithName:@"Apple Symbols" size:12.0];
//    [toggleField setStringValue:@"\udd12 \udd13 \u sdfasdf sdf"];
    self.window.delegate = self;
    self.toggleField.remoteSequence = [AppPreferences sharedAppPreferences].toggleSequence;
    self.enableField.remoteSequence = [AppPreferences sharedAppPreferences].enableSequence;
    self.disableField.remoteSequence = [AppPreferences sharedAppPreferences].disableSequence;
}




+(PrefController*) sharedPrefController {
    static PrefController* prefs = nil;
    if (!prefs)
    {
        prefs = [[PrefController alloc] initWithWindowNibName:@"PrefController"];
    }
    return prefs;
}



-(void)windowWillClose:(NSNotification *)notification {
    [[AppPreferences sharedAppPreferences] save];
    [self.delegate prefControllerClosed:self];
}

@end
