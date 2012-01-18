//
//  NSMutableArray+RemoteSequence.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoteSequence.h"
#import "HIDRemote.h"
#import "NSImage+FromGlyph.h"

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
                buttonName = @"(▲)";
                break;
                
            case kHIDRemoteButtonCodeUpHold:
                buttonName = @"(▲h)";
                break;
                
            case kHIDRemoteButtonCodeDown:
                buttonName = @"(▼)";
                break;
                
            case kHIDRemoteButtonCodeDownHold:
                buttonName = @"(▼h)";
                break;
                
            case kHIDRemoteButtonCodeLeft:
                buttonName = @"(◀)";
                break;
                
            case kHIDRemoteButtonCodeLeftHold:
                buttonName = @"(◀h)";
                break;
                
            case kHIDRemoteButtonCodeRight:
                buttonName = @"(►)";
                break;
                
            case kHIDRemoteButtonCodeRightHold:
                buttonName = @"(►h)";
                break;
                
            case kHIDRemoteButtonCodeCenter:
                buttonName = @"(●)";
                break;
                
            case kHIDRemoteButtonCodeCenterHold:
                buttonName = @"(●h)";
                break;
                
            case kHIDRemoteButtonCodeMenu:
                buttonName = @"(M)";
                break;
                
            case kHIDRemoteButtonCodeMenuHold:
                buttonName = @"(Mh)";
                break;
                
            case kHIDRemoteButtonCodePlay:
                buttonName = @"(►|)";
                break;
                
            case kHIDRemoteButtonCodePlayHold:
                buttonName = @"(►|h)";
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

-(NSAttributedString*) attributedString {
    NSMutableArray* symbols = [[NSMutableArray alloc] init];

    for (NSNumber * item in _sequence) {
        switch ([item intValue])
        {
            case kHIDRemoteButtonCodeUp:
                [symbols addObject:[NSNumber numberWithInt:SymbolUp]];
                break;
                
            case kHIDRemoteButtonCodeUpHold:
                [symbols addObject:[NSNumber numberWithInt:SymbolUp]];
                [symbols addObject:[NSNumber numberWithInt:SymbolHold]];
                break;
                
            case kHIDRemoteButtonCodeDown:
                [symbols addObject:[NSNumber numberWithInt:SymbolDown]];
                break;
                
            case kHIDRemoteButtonCodeDownHold:
                [symbols addObject:[NSNumber numberWithInt:SymbolDown]];
                [symbols addObject:[NSNumber numberWithInt:SymbolHold]];
                break;
                
            case kHIDRemoteButtonCodeLeft:
                [symbols addObject:[NSNumber numberWithInt:SymbolLeft]];
                break;
                
            case kHIDRemoteButtonCodeLeftHold:
                [symbols addObject:[NSNumber numberWithInt:SymbolLeft]];
                [symbols addObject:[NSNumber numberWithInt:SymbolHold]];

                break;
                
            case kHIDRemoteButtonCodeRight:
                [symbols addObject:[NSNumber numberWithInt:SymbolRight]];
                break;
                
            case kHIDRemoteButtonCodeRightHold:
                [symbols addObject:[NSNumber numberWithInt:SymbolRight]];
                [symbols addObject:[NSNumber numberWithInt:SymbolHold]];
                break;
                
            case kHIDRemoteButtonCodeCenter:
                [symbols addObject:[NSNumber numberWithInt:SymbolCenter]];
                break;
                
            case kHIDRemoteButtonCodeCenterHold:                
                [symbols addObject:[NSNumber numberWithInt:SymbolCenter]];
                [symbols addObject:[NSNumber numberWithInt:SymbolHold]];
                break;
                
            case kHIDRemoteButtonCodeMenu:
                [symbols addObject:[NSNumber numberWithInt:SymbolMenu]];
                break;
                
            case kHIDRemoteButtonCodeMenuHold:
                [symbols addObject:[NSNumber numberWithInt:SymbolMenu]];
                [symbols addObject:[NSNumber numberWithInt:SymbolHold]];
                break;
                
            case kHIDRemoteButtonCodePlay:
                [symbols addObject:[NSNumber numberWithInt:SymbolPlayPause]];
                break;
                
            case kHIDRemoteButtonCodePlayHold:
                [symbols addObject:[NSNumber numberWithInt:SymbolPlayPause]];
                [symbols addObject:[NSNumber numberWithInt:SymbolHold]];
                break;
        }
        [symbols addObject:[NSNumber numberWithInt:SymbolFontGID_MAX]];
    }
    
//    NSTextAttachment* attachment = nil;
//    NSImage * symbolImage = nil;
//    NSTextAttachmentCell *anAttachmentCell =nil;
//    SymbolFontGID symbol;
//    
    NSMutableAttributedString* result =   [[NSMutableAttributedString alloc] init];
    NSAttributedString* currentSymbolString = nil;
    NSLog(@"%@", symbols);
    for (NSNumber* symbolNumber in symbols) {
        SymbolFontGID symbol = [symbolNumber intValue];
        if (symbol==SymbolFontGID_MAX) {
            currentSymbolString = [[NSMutableAttributedString alloc] initWithString:@" "];
        } else {
            NSTextAttachment* attachment = [[NSTextAttachment alloc] init];
            NSImage *symbolImage = [NSImage imageFromSymbolFontGID:symbol size:12];
            NSLog(@"%@", symbolImage);
            NSTextAttachmentCell *anAttachmentCell = [[NSTextAttachmentCell
                                 alloc] initImageCell:symbolImage];
            [attachment setAttachmentCell:anAttachmentCell];
            currentSymbolString = [NSAttributedString attributedStringWithAttachment:attachment];
//            currentSymbolString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d", symbol]];
            
        }
        [result appendAttributedString:currentSymbolString];
    }
    
//    return [[NSAttributedString alloc] initWithAttributedString:result];
    NSTextAttachment* attachment = [[NSTextAttachment alloc] init];
    NSImage *symbolImage = [NSImage imageNamed:@"enabled.png"];
    NSLog(@"%@", symbolImage);
    NSTextAttachmentCell *anAttachmentCell = [[NSTextAttachmentCell
                                               alloc] initImageCell:symbolImage];
    [attachment setAttachmentCell:anAttachmentCell];
    return [NSAttributedString attributedStringWithAttachment:attachment];
}

@end
