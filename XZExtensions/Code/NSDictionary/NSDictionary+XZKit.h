//
//  NSDictionary+XZKit.h
//  XZKit
//
//  Created by Xezun on 2021/6/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType> (XZKit)

- (BOOL)xz_boolValueForKey:(KeyType)aKey;

- (NSInteger)xz_integerValueForKey:(KeyType)aKey defaultValue:(NSInteger)defaultValue;
- (NSInteger)xz_integerValueForKey:(KeyType)aKey;

- (CGFloat)xz_floatValueForKey:(KeyType)aKey defaultValue:(NSInteger)defaultValue;
- (CGFloat)xz_floatValueForKey:(KeyType)aKey;

@end

@interface NSMutableDictionary<KeyType, ObjectType> (XZKit)

- (nullable ObjectType)xz_removeObjectForKey:(KeyType)aKey;
- (NSArray<ObjectType> *)xz_removeObjectsForKeys:(NSArray<KeyType> *)keyArray;

@end


@interface NSDictionary (XZJSON)

/// 将 JSON 数据（NSData或NSString）解析为 NSDictionary 对象。
/// @param json 待解析的 JSON 数据或字符串
/// @param options 序列化选项
+ (nullable instancetype)xz_dictionaryWithJSON:(nullable id)json options:(NSJSONReadingOptions)options;
/// 将 JSON 数据（NSData或NSString）解析为 NSDictionary 对象。
/// @param json 待解析的 JSON 数据或字符串
+ (nullable instancetype)xz_dictionaryWithJSON:(nullable id)json;

@end

NS_ASSUME_NONNULL_END
