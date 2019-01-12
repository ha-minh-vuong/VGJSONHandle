
VGJSONHandle has some utility methods that can help you manipulate json object easily. It can make sure a variable is not `nil`. If it is, its value will be convert to `NSNull`. Want to get values from json, just input a key, and you don't need to know about the shape of json object. If the key exists, wherever it is, you will get its values.

Installation
------------

Copy two files VGJSONHandle.[h&m] into your project and `#import VGJSONHandle.h`.

Example
-------

* For reparing json to post to server, it can make sure variables are not `nil`. If the variables are `nil`, they will change to `NSNull`. So, when post json, the program does not crash because of `nil` variables.

```objective-c
NSString *var1 = ...;
NSString *var2 = ...;
NSString *var3 = ...;
[VGJSONHandle convertNilToNSNull:3, protect(var1), protect(var2), protect(var3)];
// Convert values of the variables to NSNull if they are nil.

NSDictionary *dict = @{@"key1": var1, @"key2": var2, @"key3": var3};
```

* For getting values from json (json example from json.org)

```json
{
    "menu": {
        "id": "file",
        "value": "File",
        "popup": {
            "menuitem": [
                {
                    "value": "New",
                    "onclick": "CreateNewDoc()"
                },
                {
                    "value": "Open",
                    "onclick": "OpenDoc()"
                },
                {
                    "value": "Close",
                    "onclick": "CloseDoc()"
                }
            ]
        }
    }
}
```

```objective-c
VGJSONHandle *jsonHandle = [[VGJSONHandle alloc] initWithJSONObject:jsonObject];

NSString *fileValue = [jsonHandle objectForKey:@"value"];
// returns the first value it found.
NSLog(@"%@", fileValue);  // fileValue ==> "File"

NSArray *onclickValues = [jsonHandle objectsForKey:@"onclick"];
// returns an array objects has the same key in json.
NSLog(@"%@", onclickValues);
// onclickValues ==> ["CreateNewDoc()", "OpenDoc()", "CloseDoc()"]

NSDictionary *dict = [jsonHandle dictionaryWithValuesForKeys:@[@"id", @"value"];
NSLog(@"%@", dict); // dict ==> {"id": "file", "value": "File",}
```

Tests
-----

Run tests in the test bundle.

License - MIT
---------------------

VGJSONHandle is available under the MIT license. See the LICENSE file for more info.
