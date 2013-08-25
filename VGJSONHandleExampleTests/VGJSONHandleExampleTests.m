//
//  VGJSONHandleExampleTests.m
//  VGJSONHandleExampleTests
//
//  Created by Ha Minh Vuong on 8/24/13.
//  Copyright (c) 2013 Ha Minh Vuong. All rights reserved.
//

#import "VGJSONHandleExampleTests.h"

@interface VGJSONHandleExampleTests()
@property (nonatomic, strong) id jsonObject;
@end

@implementation VGJSONHandleExampleTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Tear-down code here.
    self.jsonObject = nil;
    [super tearDown];
}

- (void)testNullInputJSON
{
    VGJSONHandle *vg = [[VGJSONHandle alloc] initWithJSONObject:nil];
    id value = [vg objectForKey:@"blab"];
    NSLog(@"%@", value);
    STAssertNil(value, @"");
}

- (void)testObjectForKey1
{
    NSString *jsonString =  @"{ \"name\": \"nameValue\",\
                                \"address\": [{\"street\":\"1 abc\",\
                                               \"city\":\"abc\"},\
                                              {\"street\":\"2 def\",\
                                               \"city\":\"def\"},\
                                              {\"street\":\"3 ghi\",\
                                               \"city\":\"ghi\"}],\
                                \"gender\":\"male\",\
                                \"single\":true,\
                                \"children\":null }";
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    
    VGJSONHandle *vg = [[VGJSONHandle alloc] initWithJSONObject:self.jsonObject];
    id value = [vg objectForKey:@"children"];
    NSLog(@"%@", value);
    STAssertEquals(value, [NSNull null], @"");
}

- (void)testObjectForKey2
{
    NSString *jsonString =  @"[{ \"name\": \"nameValue\",\
    \"address\": [{\"street\":\"1 abc\",\
    \"city\":\"abc\"},\
    {\"street\":\"2 def\",\
    \"city\":\"def\"},\
    {\"street\":\"3 ghi\",\
    \"city\":\"ghi\"}],\
    \"gender\":\"male\",\
    \"single\":true,\
    \"children\":null }]";
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    
    VGJSONHandle *vg = [[VGJSONHandle alloc] initWithJSONObject:self.jsonObject];
    id value = [vg objectForKey:@"street"];
    NSLog(@"%@", value);
    STAssertTrue([value isEqualToString:@"1 abc"], @"");
}

- (void)testObjectForKeyPath1
{
    NSString *jsonString =  @"{ \"name\": \"nameValue\",\
                                \"address\": { \"street\":\"1 abc\",\
                                               \"city\":\"abc\",\
                                               \"another\": [{\"one\": \"oneValue\",\
                                                             \"two\":\"twoValue\"}] },\
                                \"gender\":\"male\",\
                                \"single\":true,\
                                \"children\":null }";
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    VGJSONHandle *vg = [[VGJSONHandle alloc] initWithJSONObject:self.jsonObject];
    id value = [vg objectForKeyPath:@"address.another"];
    NSLog(@"%@", value);
    STAssertNotNil(value, @"");
}

- (void)testObjectForKeyPath2
{
    NSString *jsonString =  @"{ \"name\": \"nameValue\",\
    \"address\": { \"street\":\"1 abc\",\
    \"city\":\"abc\",\
    \"another\": {\"one\": \"oneValue\",\
    \"two\":\"twoValue\"} },\
    \"gender\":\"male\",\
    \"single\":true,\
    \"children\":null }";
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    VGJSONHandle *vg = [[VGJSONHandle alloc] initWithJSONObject:self.jsonObject];
    id value = [vg objectForKeyPath:@"address.another.two"];
    NSLog(@"%@", value);
    STAssertTrue([value isEqualToString:@"twoValue"], @"");
}

- (void)testConvertNilToNull
{
    NSString *a;
    int b = 0; // 31233656
    NSString *c = @"not nil";
    BOOL d = NO;
    NSNumber *e = @(0);//= [NSNumber numberWithBool:NO];
    
    [VGJSONHandle convertNilToNSNull:5, protect(a), protect(b), protect(c), protect(d), protect(e)];

    NSLog(@"a: %@,\nb: %@,\nc: %@,\nd: %@,\ne: %@", a, @(b), c, @(d), e);
    NSDictionary *dict = @{@"a": a, @"b": @(b), @"c": c, @"d": @(d), @"e": e};
    NSLog(@"%@", dict);
    STAssertNotNil(dict, @"");
}

- (void)testDictionaryForKeys
{
    NSString *jsonString =  @"{ \"name\": \"nameValue\",\
                                \"address\": { \"street\":\"1 abc\",\
                                               \"city\":\"abc\",\
                                               \"another\": { \"one\": \"oneValue\",\
                                                              \"two\":\"twoValue\"} },\
                                \"gender\":\"male\",\
                                \"single\":true,\
                                \"children\":null }";
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    self.jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    VGJSONHandle *vg = [[VGJSONHandle alloc] initWithJSONObject:self.jsonObject];
    NSDictionary *dict = [vg dictionaryForKeys:@[@"city", @"two", @"children"]];
    NSLog(@"%@", dict);
    STAssertNotNil(dict, @"The result can not be nil");
    STAssertTrue([dict[@"city"] isEqualToString:@"abc"], @"");
    STAssertTrue([dict[@"two"] isEqualToString:@"twoValue"], @"");
    STAssertTrue(dict[@"children"] == [NSNull null], @"");
}

@end
