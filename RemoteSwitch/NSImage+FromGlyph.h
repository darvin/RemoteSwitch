//
//  NSImage+FromGlyph.h
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <AppKit/AppKit.h>
typedef enum {
    SymbolLock = 5002,
    SymbolUnlock,
    SymbolPlayPause = 5020,
    SymbolHold = 5038,
    SymbolMenu,
    SymbolUp = 5104,
    SymbolCenter,
    SymbolDown,
    SymbolLeft = 5108,
    SymbolRight,
    SymbolPause,
    SymbolFontGID_MAX
    
}SymbolFontGID;
@interface NSImage (FromGlyph)
+(NSImage*) imageFromSymbolFontGID: (SymbolFontGID)gid;
+(NSImage*) imageFromSymbolFontGID: (SymbolFontGID)gid size:(NSUInteger)size;
@end
