//
//  CryptorUtil.h
//  global
//
//  Created by jbas on 15/5/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CryptorUtil : NSObject

//用DES算法加密
+(NSString *) encryptUseDES:(NSString *)clearText;

//用DES算法解密
+(NSString*) decryptUseDES:(NSString*)cipherText;

@end
