//
//  VGJSONHandle.h
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

#import <Foundation/Foundation.h>

#define protect(value) &value


@interface VGJSONHandle : NSObject


/*!
 * nil variable will change its value to NSNull.
 * @discussion Make nil variable contains NSNull. 
 * The variable won't be touched if it stores a value.
 * @param count The number of variables need to convert.
 * @param ... A comma-separated list of variables need to convert.
 */
+ (void)convertNilToNSNull:(NSUInteger)count,...;

/*!
 * Returns the JSON object of receiver.
 */
@property (nonatomic, readonly) id jsonObject;

/*!
 * Initializes a new object with a specified JSON.
 * @param jsonObject The input JSON object.
 * @return The newly initialized object.
 */
- (id)initWithJSONObject:(id)jsonObject;

/*!
 * Returns an array of values for a specific key in JSON.
 * @discussion Collect all the values of a specific key in JSON into an array.
 * @param key The key for which searching value.
 * @return The array of values for the key.
 */
- (NSArray *)objectsForKey:(NSString *)key;

/*!
 * Returns a value for a specific key in JSON.
 * @discussion This method searches the key in JSON object.
 * When the first key was found, the method returns its value returned immediately.
 * When the key was not found, it returns nil.
 * @key key The key for which searching value.
 * @return The value for the key, nil if key does not existed.
 */
- (id)objectForKey:(NSString *)key;

- (id)objectForKeyPath:(NSString *)keyPath;

- (NSDictionary *)dictionaryForKeys:(NSArray *)keys;

@end
