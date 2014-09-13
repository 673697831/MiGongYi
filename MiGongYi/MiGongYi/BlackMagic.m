//
//  BlackMagic.m
//  MiGongYi
//
//  Created by megil on 9/3/14.
//  Copyright (c) 2014 megil. All rights reserved.
//

#import "BlackMagic.h"
#import <objc/runtime.h>

@implementation BlackMagic
+ (void) blackMagicAFJSONResponseSerializer
{
    Class c = objc_getClass("AFJSONResponseSerializer");
    id block = ^NSSet*()
    {
        return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    };
    
    SEL selctor = NSSelectorFromString(@"acceptableContentTypes");
    IMP test = imp_implementationWithBlock(block);
    Method origMethod = class_getInstanceMethod(c,
                                                selctor);
    
    if(!class_addMethod(c, selctor, test,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, test);
    }
}
@end
