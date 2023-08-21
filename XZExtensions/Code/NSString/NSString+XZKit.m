//
//  NSString+XZKit.m
//  XZKit
//
//  Created by Xezun on 2021/6/23.
//

#import "NSString+XZKit.h"
#import <XZExtensions/NSCharacterSet+XZKit.h>
#import <CoreText/CoreText.h>
#import <objc/NSObjCRuntime.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (XZKit)

- (void)xz_enumerateSubstringsMatchedGlyphInFont:(UIFont *)textFont usingBlock:(void (^)(NSRange range))block {
    if (block == nil || textFont == nil) {
        return;
    }
    
    CTFontRef const font = CTFontCreateWithName((__bridge CFStringRef)[textFont fontName], textFont.pointSize, NULL);
    UniChar * const cext = (UniChar *)[self cStringUsingEncoding:NSUTF16StringEncoding]; // CoreText 使用 UTF16 编码
    
    BOOL    __block start = NO;
    NSRange __block range = NSMakeRange(NSNotFound, 0);
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        CGGlyph glyph[10];
        if (CTFontGetGlyphsForCharacters(font, cext + enclosingRange.location, glyph, enclosingRange.length)) {
            if (start) {
                range.length += enclosingRange.length;
            } else {
                start = YES;
                range = enclosingRange;
            }
            return;
        }
        if (start) {
            block(range);
            range.location = NSNotFound;
            start = NO;
        }
    }];
    
    if (start) {
        block(range);
    }
}

- (CGFloat)xz_floatValue {
    return [self xz_floatValue:0];
}

- (CGFloat)xz_floatValue:(CGFloat)defaultValue {
    if (self.length == 0) {
        return defaultValue;
    }
    const char *str = self.UTF8String;
    char *ptr;
#if CGFLOAT_IS_DOUBLE
    CGFloat const value = strtod(str, &ptr);
#else
    CGFloat const value = strtof(str, &ptr);
#endif
    return ptr == NULL ? value : (ptr[0] == '\0' ? value : defaultValue);
}

- (NSInteger)xz_integerValue {
    return [self xz_integerValue:0 base:10];
}

- (NSInteger)xz_integerValue:(NSInteger)defaultValue base:(int)base {
    if (self.length == 0) {
        return defaultValue;
    }
    const char *str = self.UTF8String;
    char *ptr;
    long const value = strtol(str, &ptr, base);
    return (NSInteger)(ptr == NULL ? value : (ptr[0] == '\0' ? value : defaultValue));
}

- (NSString *)xz_md5 {
    const char * const data   = [self UTF8String];
    CC_LONG      const length = (CC_LONG)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[16];
    CC_MD5(data, length, result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15] ];
}

- (NSString *)xz_MD5 {
    const char * const data   = [self UTF8String];
    CC_LONG      const length = (CC_LONG)[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[16];
    CC_MD5(data, length, result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

- (NSString *)xz_stringByAddingPercentEncoding {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.xz_letterAndDigitCharacterSet];
}

- (NSString *)xz_stringByAddingURIEncoding {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.xz_URIAllowedCharacterSet];
}

- (NSString *)xz_stringByAddingURIComponentEncoding {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.xz_URIComponentAllowedCharacterSet];
}

@end
