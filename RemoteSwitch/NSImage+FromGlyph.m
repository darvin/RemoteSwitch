//
//  NSImage+FromGlyph.m
//  RemoteSwitch
//
//  Created by Sergey Klimov on 12/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSImage+FromGlyph.h"

@implementation NSImage (FromGlyph)
+(NSImage*) imageFromSymbolFontGID: (SymbolFontGID)gid size:(NSUInteger)size{
    NSFont *font = [NSFont fontWithName:@"Apple Symbols" size:size];
    NSBezierPath *path = [NSBezierPath bezierPath];
    NSGlyph glyph = [font glyphWithName:[NSString stringWithFormat:@"gid%d",gid]];
    [path moveToPoint:NSMakePoint(3, 3)];
    [path appendBezierPathWithGlyph:glyph inFont:font];
    
    NSColor * myColour = [NSColor blackColor];
    
    
    NSSize imageSize = NSMakeSize( [path bounds].size.width + [path bounds].origin.x +2,
                             [path bounds].size.height + [path bounds].origin.y +2);

    
    NSImage* image = [[NSImage alloc] initWithSize:imageSize];

    
    
    [image lockFocus];
    [myColour set];
    [path stroke];
    [path fill];
    [image unlockFocus];
    return image;
}

+(NSImage*) imageFromSymbolFontGID: (SymbolFontGID)gid {
    return [self imageFromSymbolFontGID:gid size:20];
}

@end
