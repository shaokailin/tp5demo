//
//  UIColor+Hex.m
//  PuzzlePicture
//
//  Created by 李亚军 on 16/6/20.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithHexString:(id)hexString {
    if (![hexString isKindOfClass:[NSString class]] || [hexString length] == 0) {
        return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    
    const char *s = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
    if (*s == '#') {
        ++s;
    }
    unsigned long long value = strtoll(s, nil, 16);
    int r, g, b, a;
    switch (strlen(s)) {
        case 2:
            // xx
            r = g = b = (int)value;
            a = 255;
            break;
        case 3:
            // RGB
            r = ((value & 0xf00) >> 8);
            g = ((value & 0x0f0) >> 4);
            b = ((value & 0x00f) >> 0);
            r = r * 16 + r;
            g = g * 16 + g;
            b = b * 16 + b;
            a = 255;
            break;
        case 6:
            // RRGGBB
            r = (value & 0xff0000) >> 16;
            g = (value & 0x00ff00) >>  8;
            b = (value & 0x0000ff) >>  0;
            a = 255;
            break;
        default:
            // RRGGBBAA
            r = (value & 0xff000000) >> 24;
            g = (value & 0x00ff0000) >> 16;
            b = (value & 0x0000ff00) >>  8;
            a = (value & 0x000000ff) >>  0;
            break;
    }
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}
@end
