# XZExtensions

[![CI Status](https://img.shields.io/travis/xezun/XZExtensions.svg?style=flat)](https://travis-ci.org/xezun/XZExtensions)
[![Version](https://img.shields.io/cocoapods/v/XZExtensions.svg?style=flat)](https://cocoapods.org/pods/XZExtensions)
[![License](https://img.shields.io/cocoapods/l/XZExtensions.svg?style=flat)](https://cocoapods.org/pods/XZExtensions)
[![Platform](https://img.shields.io/cocoapods/p/XZExtensions.svg?style=flat)](https://cocoapods.org/pods/XZExtensions)

本库是对原生框架的拓展，为原生类添加一些常用方法和属性，以降低代码重复，提高开发效率。

## Example

To run the example project, clone the repo, and run `pod install` from the Pods directory first.

## Requirements

iOS 11.0, Xcode 14.0

## Installation

XZExtensions is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'XZExtensions'
```

## 功能特性

### CAAnimation

1. 抖动动画

```objc
CAAnimation *ani = [CAAnimation xz_vibrateAnimationWithAmplitudeX:3 y:0 z:0];
```

### CALayer

1. 隐式动画

```objc
[CALayer xz_animateWithDuration:1.0 animations:^{
    // config the layer's properties
}];
```

### NSArray

1. 判断是否包含重复元素
2. 拓展 reduce/map/compactMap/filter 等高级函数
3. 差异分析
4. JSON 序列化

### NSAttributedString

1. 给富文本添加字体

### NSBundle

1. 获取版本号、构建版本号

### NSCharacterSet

1. 符合通用规范的 URI/URIComponent 字符集

### NSData

1. 十六进制编码

### NSIndexSet

1. reduce/map/compactMap 高级函数

### NSObject

1. 遍历 keyPath 及相关方法


### NSString

1. 查找字体是否包含
2. 取 integer/float 值
4. UIR 编码
6. 十六进制编码
7. JSON


### UIApplication

1. 状态栏


### UIBezierPath

1. 画五角星


### UIColor

1. RGB 颜色

### UIDevice

1. 获取设备型号、主板型号

### UIFont

1. 注册字体
2. 判断字体是否包含字形

### UIImage

1. 修改透明度
2. 修改宣染色
3. 修改亮度
4. 修改色阶

### UIView

1. 遍历层级关系、输出
2. 截图

### UIViewController

1. 状态栏控制






## Author

Xezun, developer@xezun.com

## License

XZExtensions is available under the MIT license. See the LICENSE file for more info.
