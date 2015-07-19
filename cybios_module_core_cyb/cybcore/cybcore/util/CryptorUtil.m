//
//  CryptorUtil.m
//  global
//
//  Created by jbas on 15/5/15.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "CryptorUtil.h"
#include <CommonCrypto/CommonCryptor.h>
#import "NSData+AES256.h"

#define k_Key @"chuyoubao2014"
@implementation CryptorUtil

+(NSString *)encryptUseDES:(NSString *)clearText{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encryptedData = [[data AES256EncryptWithKey:k_Key] base64EncodedStringWithOptions:0];
    encryptedData = [encryptedData stringByReplacingOccurrencesOfString :@"+" withString:@"-"];
    encryptedData = [encryptedData stringByReplacingOccurrencesOfString :@"/" withString:@"_"];
    if ([[encryptedData substringFromIndex:(encryptedData.length-2)] isEqualToString:@"="]) {
        encryptedData=[encryptedData substringToIndex:(encryptedData.length-2)];
    }else if ([[encryptedData substringFromIndex:encryptedData.length-1] isEqualToString:@"="]){
        encryptedData=[encryptedData substringToIndex:(encryptedData.length-1)];
    }
    
    return encryptedData;
}

+(NSString *)decryptUseDES:(NSString *)cipherText{
    NSData *data = [cipherText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *cleardData = [[data AES256DecryptWithKey:k_Key] base64EncodedStringWithOptions:0];
    return cleardData;
}

@end
