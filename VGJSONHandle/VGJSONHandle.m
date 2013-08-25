//
//  VGJSONHandle.m
//  VGJSONHandle
//
//  Copyright (c) 2013 Ha Minh Vuong
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "VGJSONHandle.h"

#define kPath @"."


@interface VGJSONHandle()
@property (nonatomic, readwrite) id jsonObject;
@end

@implementation VGJSONHandle

+ (void)convertNilToNSNull:(NSUInteger)count,...
{
    NSParameterAssert(count > 0);
    va_list args;
    va_start(args, count);
    for (NSUInteger i = 0; i < count; i++) {
        __strong id *val = va_arg(args, __strong id *);
        if (!*val) {
            *val = [NSNull null];
        }
    }
    va_end(args);
}

- (id)initWithJSONObject:(id)jsonObject
{
    if (self = [super init]) {
        _jsonObject = jsonObject;
    }
    return self;
}

- (id)objectForKeyPath:(NSString *)keyPath
{
    id result;
    NSArray *array = [keyPath componentsSeparatedByString:kPath];
    id jsonObject = [self.jsonObject copy];
    id obj;
    for (NSString *key in array) {
        obj = nil;
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            obj = jsonObject[key];
        }
        jsonObject = obj;
        if (!jsonObject) {
            break;
        }
    }
    result = jsonObject;
    return result;
}

- (NSDictionary *)dictionaryForKeys:(NSArray *)keys
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    for (NSString *key in keys) {
        id obj = [self objectForKey:key];
        if (obj) {
            [result addEntriesFromDictionary:@{key: obj}];
        }
    }
    if (result.count != keys.count) {
        NSMutableSet *keySet = [NSMutableSet setWithArray:keys];
        NSMutableSet *resultKeySet = [NSMutableSet setWithArray:[result allKeys]];
        [keySet minusSet:resultKeySet];
        NSLog(@"* WARNING *: The following keys does not exist in JSON:\n%@", keySet);
    }
    return [NSDictionary dictionaryWithDictionary:result];
}

- (id)objectForKey:(NSString *)key
{
    id result;
    [self objectForKey:key inJSONObject:self.jsonObject value:&result];
    return result;
}

- (NSArray *)objectsForKey:(NSString *)key
{
    NSMutableArray *result = [NSMutableArray array];
    [self objectsForKey:key inJSONObject:self.jsonObject marray:result];
    return [NSArray arrayWithArray:result];
}

- (void)objectForKey:(NSString *)key inJSONObject:(id)jsonObject value:(id*)value
{
    if (!*value) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            for (id k in [jsonObject allKeys]) {
                id obj = [jsonObject objectForKey:k];
                if ([key isEqualToString:k]) {
                    *value = [jsonObject objectForKey:key];
                    return;
                } else if ([obj isKindOfClass:[NSDictionary class]] ||
                           [obj isKindOfClass:[NSArray class]]) {
                    [self objectForKey:key inJSONObject:obj value:value];
                }
            }
        } else if ([jsonObject isKindOfClass:[NSArray class]]) {
            for (id obj in jsonObject) {
                if ([obj isKindOfClass:[NSDictionary class]] ||
                    [obj isKindOfClass:[NSArray class]]) {
                    [self objectForKey:key inJSONObject:obj value:value];
                }
            }
        }
    }
}

- (void)objectsForKey:(NSString *)key inJSONObject:(id)jsonObject marray:(NSMutableArray *)marray
{
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        for (id k in [jsonObject allKeys]) {
            id obj = [jsonObject objectForKey:k];
            if ([key isEqualToString:k]) {
                id jso = [jsonObject objectForKey:key];
                [marray addObject:jso];
                return;
            } else if ([obj isKindOfClass:[NSDictionary class]] ||
                       [obj isKindOfClass:[NSArray class]]) {
                [self objectsForKey:key inJSONObject:obj marray:marray];
            }
        }
    } else if ([jsonObject isKindOfClass:[NSArray class]]) {
        for (id obj in jsonObject) {
            if ([obj isKindOfClass:[NSDictionary class]] ||
                [obj isKindOfClass:[NSArray class]]) {
                [self objectsForKey:key inJSONObject:obj marray:marray];
            }
        }
    }
}

@end
