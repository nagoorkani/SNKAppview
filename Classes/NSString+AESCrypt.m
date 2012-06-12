//
//  NSString+AESCrypt.m
//  SNKAppView
//
//  Created by Nagoor Kani Sheik Maideen on 6/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import "NSString+AESCrypt.h"

@implementation NSString (AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key
{
	NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSData *encryptedData = [plainData AES256EncryptWithKey:key];
	
	NSString *encryptedString = [encryptedData base64Encoding];
	
	return encryptedString;
}

- (NSData *)AES256DataEncryptWithKey:(NSString *)key
{
	NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSData *encryptedData = [plainData AES256EncryptWithKey:key];
	
	NSString *encryptedString = [encryptedData base64Encoding];
	
	return encryptedString;
}


- (NSString *)AES256DecryptWithKey:(NSString *)key
{
	NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
	NSData *plainData = [encryptedData AES256DecryptWithKey:key];
	
	NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
	
	return [plainString autorelease];
}


- (NSString *)AES256EncryptFileWithKey:(NSString *)key
{

//	NSData *selfData = [NSData dataWithBase64EncodedString:self];
//
//	NSString *str = [[NSString alloc]initWithData:selfData encoding:NSUTF8StringEncoding];	
//	
//	NSLog(@"Data: %@", str);

	NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
	NSData *encryptedData = [plainData AES256EncryptWithKey:key];
	
	NSString *encryptedString = [encryptedData base64Encoding];
	
	return encryptedString;	
	
	
//	NSString *path1 = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
//	NSData *plainData = [NSData dataWithContentsOfFile:path1];
//	NSData *encryptedData = [plainData AES256EncryptWithKey:key];
//	
//	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.txt"];
//	
//	[encryptedData writeToFile:filePath options:NSDataWritingAtomic error:nil];
	
	//return encryptedString;
}

- (NSString *)AES256DecryptFileWithKey:(NSString *)key
{

	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"index.html"];
	
	NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
	NSData *plainData = [encryptedData AES256DecryptWithKey:key];
	
	NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
	
	[encryptedData writeToFile:filePath options:NSDataWritingAtomic error:nil];
	
	
//	return [plainString autorelease];
}



@end

