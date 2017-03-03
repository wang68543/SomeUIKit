//
//  NSCoderObject.m
//  Guardian
//
//  Created by WangQiang on 16/7/30.
//  Copyright © 2016年 WangQiang. All rights reserved.
//

#import "NSCoderObject.h"
#import <objc/runtime.h>

@implementation NSCoderObject
-(instancetype)initSelfWithDict:(NSDictionary *)dict{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)classWithDict:(NSDictionary *)dict{
    if(![dict isKindOfClass:[NSDictionary class]]) return nil;
    return [[self alloc] initSelfWithDict:dict];
}

+(NSArray *)classesWithArray:(NSArray *)array{
    if(![array isKindOfClass:[NSArray class]] || array.count <= 0) return [NSArray array];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        NSCoderObject *obj = [self classWithDict:dic];
        if(obj){
            [items addObject:obj];
        }
    }
    return [items copy];
}

+(NSArray *)classesWithArray:(NSArray *)array classInArray:(NSDictionary *)inArrayModels{
    if(![array isKindOfClass:[NSArray class]]) return [NSArray array];
    NSMutableArray *items = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        NSCoderObject *obj = [self classWithDict:dic classInDict:inArrayModels];
        if(obj){
            [items addObject:obj];
        }
    }
    return items;
}
+(instancetype)classWithDict:(NSDictionary *)dict classInDict:(NSDictionary *)inDictModels{
    if([dict isKindOfClass:[NSDictionary class]]){
        return [[self alloc] init];
    }else{
      return [[self alloc] initWithDict:dict classInDict:inDictModels];
    }
    
}
-(NSArray *)properties{
    NSMutableArray *properties = [NSMutableArray array];
    unsigned int count = 0;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *property = [NSString stringWithUTF8String:propertyName];
        [properties addObject:property];
    }
    free(propertyList);
    return properties;
}

-(instancetype)initWithDict:(NSDictionary *)dict classInDict:(NSDictionary *)inDictModels{
    
    if(self = [super init]){
        __weak typeof(self) weakSelf = self;
        __weak  NSArray *properties = [self properties];
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[NSDictionary class]]){
                if([properties containsObject:key]){
                    Class modelClass = NSClassFromString([inDictModels valueForKey:key]);
                    if(modelClass){
                        [weakSelf setValue:[modelClass classWithDict:obj] forKey:key];
                    }else{
                        [weakSelf setValue:obj forUndefinedKey:key];
                    }
                }else{
                    [weakSelf setValue:obj forUndefinedKey:key];
                }
            }else if([obj isKindOfClass:[NSArray class]]){
                if([properties containsObject:key]){
                    Class modelClass = NSClassFromString([inDictModels valueForKey:key]);
                    if(modelClass){
                        [weakSelf setValue:[modelClass classesWithArray:obj] forKey:key];
                    }else{
                        [weakSelf setValue:obj forUndefinedKey:key];
                    }
                    
                }else{
                    [weakSelf setValue:obj forUndefinedKey:key];
                }
            }else if([properties containsObject:key] ){
                [weakSelf setValue:obj forKey:key];
            }else{
                [weakSelf setValue:obj forUndefinedKey:key];
            }
        }];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder

{
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        // 查看成员变量
        
        const char *name = ivar_getName(ivar);
        // 归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        const char *typeCh = ivar_getTypeEncoding(ivar);
        NSString *type = [NSString stringWithUTF8String:typeCh];
        if([type rangeOfString:@"NS"].location == NSNotFound){
            [encoder encodeInteger:(NSInteger)value forKey:key];
        }else{
          [encoder encodeObject:value forKey:key];
        }
    }
    
    free(ivars);
    
    
}

- (instancetype)initWithCoder:(NSCoder *)decoder

{
    if (self = [super init]) {
        
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self  class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            const char *typeCh = ivar_getTypeEncoding(ivar);
            NSString *type = [NSString stringWithUTF8String:typeCh];
            if([type rangeOfString:@"NS"].location == NSNotFound){
                [self setValue:@([decoder decodeIntegerForKey:key]) forKey:key];
            }else{
               [self setValue:[decoder decodeObjectForKey:key] forKey:key];
            }
        }
        free(ivars);
        
    }
    return self;
    
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
//防止出错
//    if([key isEqualToString:@"id"]){
//        
//    }
}

-(instancetype)copyItem{
   
    NSCoderObject *obj = [[[self class] alloc] init];
     unsigned int count = 0;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSString *property = [NSString stringWithUTF8String:propertyName];
        [obj setValue:[self valueForKey:property] forKey:property];
    }
    return obj ;
}
@end
