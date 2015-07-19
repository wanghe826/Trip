//
//  NSData+AES256.h
//  crypto
//
//  Created by jbas on 15/5/14.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

- (NSData *)AES256EncryptWithKey:(NSString *)key;

- (NSData *)AES256DecryptWithKey:(NSString *)key;

@end
