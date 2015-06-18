# mailbox

-
###当输入邮箱账号时，邮箱后缀的智能联想。
所有效果均参照新浪微博的登录实现，只是一个简单的逻辑，核心代码请看- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
方法。

-
###效果图<br>
![](https://github.com/YAANNZ/mailbox/blob/master/gif/mailbox.gif "演示")

-
###有任何问题和建议还请Issues。

-
### <a id="Camel_underline"></a> Camel -> underline
```objc
// Dog 
#import "MJExtension.h"

@implementation Dog
+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName
{
    // nickName -> nick_name
    return [propertyName underlineFromCamel];
}
@end

// NSDictionary
NSDictionary *dict = @{
                       @"nick_name" : @"旺财",
                       @"sale_price" : @"10.5",
                       @"run_speed" : @"100.9"
                       };
// NSDictionary -> Dog
Dog *dog = [Dog objectWithKeyValues:dict];

// printing
NSLog(@"nickName=%@, scalePrice=%f runSpeed=%f", dog.nickName, dog.salePrice, dog.runSpeed);
```

### <a id="NSString_NSDate_nil_@"""></a> NSString -> NSDate nil -> @""
```objc
// Book
#import "MJExtension.h"

@implementation Book
- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"publisher"]) {
        if (oldValue == nil) return @"";
    } else if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt dateFromString:oldValue];
    }

    return oldValue;
}
@end

// NSDictionary
NSDictionary *dict = @{
                       @"name" : @"5分钟突破iOS开发",
                       @"publishedTime" : @"2011-09-10"
                       };
// NSDictionary -> Book
Book *book = [Book objectWithKeyValues:dict];

// printing
NSLog(@"name=%@, publisher=%@, publishedTime=%@", book.name, book.publisher, book.publishedTime);
```

## 统一转换属性名（比如驼峰转下划线）
```objc
// Dog模型
#import "MJExtension.h"

@implementation Dog
+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName
{
    // nickName -> nick_name
    return [propertyName underlineFromCamel];
}
@end

// 定义一个字典
NSDictionary *dict = @{
                       @"nick_name" : @"旺财",
                       @"sale_price" : @"10.5",
                       @"run_speed" : @"100.9"
                       };
// 将字典转为Dog模型
Dog *dog = [Dog objectWithKeyValues:dict];

// 打印Dog模型的属性
NSLog(@"nickName=%@, scalePrice=%f runSpeed=%f", dog.nickName, dog.salePrice, dog.runSpeed);
```
##### 核心代码
* `+ (NSString *)replacedKeyFromPropertyName121:(NSString *)propertyName;`


## 过滤字典的值（比如字符串日期处理为NSDate、字符串nil处理为@""）
```objc
// Book模型
#import "MJExtension.h"

@implementation Book
- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if ([property.name isEqualToString:@"publisher"]) {
        if (oldValue == nil) return @"";
    } else if (property.type.typeClass == [NSDate class]) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt dateFromString:oldValue];
    }
    
    return oldValue;
}
@end

// 定义一个字典
NSDictionary *dict = @{
                       @"name" : @"5分钟突破iOS开发",
                       @"publishedTime" : @"2011-09-10"
                       };
// 将字典转为Book模型
Book *book = [Book objectWithKeyValues:dict];

// 打印Book模型的属性
NSLog(@"name=%@, publisher=%@, publishedTime=%@", book.name, book.publisher, book.publishedTime);
```
##### 核心代码
* `- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property;`
