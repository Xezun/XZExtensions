//
//  NSBundle+XZKit.h
//  XZKit
//
//  Created by Xezun on 2021/11/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (XZKit)

/// 构建版本。
@property (nonatomic, readonly) NSString *xz_buildVersionString;
/// 发行版本。
@property (nonatomic, readonly) NSString *xz_shortVersionString;
/// 可执行文件名。
@property (nonatomic, readonly) NSString *xz_executableName;

@end

NS_ASSUME_NONNULL_END
