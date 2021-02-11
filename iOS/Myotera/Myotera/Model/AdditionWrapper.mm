#import <Foundation/Foundation.h>

#import "AdditionWrapper.h"
#import "addition.h"

@implementation AdditionWrapper

- (NSString *) Addition {
    std::string result = std::to_string(Addition(1, 2).doAdd());
    return [NSString
            stringWithCString:result.c_str()
            encoding:NSUTF8StringEncoding];
}
@end
