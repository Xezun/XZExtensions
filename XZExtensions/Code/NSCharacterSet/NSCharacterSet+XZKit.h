//
//  NSCharacterSet+XZKit.h
//  XZKit
//
//  Created by Xezun on 2021/11/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCharacterSet (XZKit)

/// 进行 URI 编码时，不会被转义的字符集。
/// @discussion 如下字符不会被转义
/// @code
/// A-Z a-z 0-9 ; , / ? : @ & = + $ - _ . ! ~ * ' ( ) #
/// @endcode
/// @see [JavaScript - encodeURI](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURI#description)
@property (class, readonly) NSCharacterSet *xz_URIAllowedCharacterSet;

/// 进行 URIComponent 编码时，不会被转义的字符集。
/// @discussion 如下字符不会被转义
/// @code
/// A-Z a-z 0-9 - _ . ! ~ * ' ( )
/// @endcode
/// @see [JavaScript - encodeURIComponent](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent#description)
@property (class, readonly) NSCharacterSet *xz_URIComponentAllowedCharacterSet;

/// 仅包含 A-Z、a-z、0-9 共62个字符的字符集。
@property (class, readonly) NSCharacterSet *xz_letterAndDigitCharacterSet;

@end

NS_ASSUME_NONNULL_END
