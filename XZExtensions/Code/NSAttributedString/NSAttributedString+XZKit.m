//
//  NSAttributedString+XZKit.m
//  XZKit
//
//  Created by Xezun on 2021/10/5.
//

#import "NSAttributedString+XZKit.h"
#import "NSString+XZKit.h"

@implementation NSAttributedString (XZKit)

- (NSAttributedString *)xz_attributedStringByAddingFontAttributeForCharatersMatchedGlyphInFont:(UIFont *)font {
    if (font == nil) {
        return self;
    }
    NSMutableAttributedString *attributedStringM = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [attributedStringM xz_addFontAttributeForCharatersMatchedGlyphInFont:font];
    return attributedStringM;
}

@end


@implementation NSMutableAttributedString (XZKit)

- (void)xz_addFontAttributeForCharatersMatchedGlyphInFont:(UIFont *)font {
    if (font == nil) {
        return;
    }
    [self.string xz_enumerateSubstringsMatchedGlyphInFont:font usingBlock:^(NSRange range) {
        [self addAttribute:NSFontAttributeName value:font range:range];
    }];
}

@end


