//
//  NSData+AESCrypt.h
//  SNKAppView
//
//  Created by Nagoor Kani Sheik Maideen on 6/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSData (AESCrypt)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (id)initWithBase64EncodedString:(NSString *)string;

- (NSString *)base64Encoding;
- (NSString *)base64EncodingWithLineLength:(NSUInteger)lineLength;

- (BOOL)hasPrefixBytes:(const void *)prefix length:(NSUInteger)length;
- (BOOL)hasSuffixBytes:(const void *)suffix length:(NSUInteger)length;

@end