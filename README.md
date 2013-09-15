
Installation
------------

Copy two files VGJSONHandle.[h&m] into your project and `#import VGJSONHandle.h`.

Example
-------

* For posting json, it can make sure variables are not `nil`. If the variables are nil, they will change to NSNull. So, when post json, the program does not crash.

```objective-c
NSString *var1 = ...;
NSString *var2 = ...;
NSString *var3 = ...;
[VGJSONHandle convertNilToNSNull:5, protect(var1), protect(var2), protect(var3)];
// Convert values of the variables to NSNull if they are nil. 
```
 
Tests
-----

Run tests in the test bundle.

License - MIT
---------------------

VGJSONHandle is available under the MIT license. See the LICENSE file for more info.