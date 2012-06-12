//
//  SNKAppViewViewController.m
//  SNKAppView
//
//  Created by Nagoor Kani Sheik Maideen on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SNKAppViewViewController.h"

@implementation SNKAppViewViewController


/*
 Button click
 */
-(IBAction)displayText{
	
	lblPrint.text = txtName.text;
	
}

-(IBAction)encryptValue{

	NSString *path1 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    NSData *d = [NSData dataWithContentsOfFile:path1];

	//NSString *myString = [NSString stringWithFormat:@"%@",txtName.text];
	NSString * _key = @"key123";
	
	NSString *encryptedString = [d AES256DataEncryptWithKey:_key];
	
	lblPrint.text = [NSString stringWithFormat:@"%@", encryptedString];
}

-(IBAction)decryptValue{

	NSString *myString = [NSString stringWithFormat:@"%@",lblPrint.text];
	NSString * _key = @"key123";
	
	NSString *decryptedString = [myString AES256DecryptWithKey:_key];
	NSLog(@"Decrypted ID : %@", decryptedString);
	
	lblPrint.text = [NSString stringWithFormat:@"%@", decryptedString];
}

-(IBAction)sliderChanged{
	lblPrint.text = [NSString stringWithFormat:@"%f",sliderValue.value];
}


-(IBAction)changeBGColor{
	if(switchColor.on){
		lblPrint.backgroundColor = [UIColor greenColor];
	}else{
		lblPrint.backgroundColor = [UIColor grayColor];
	}
}

-(IBAction)decryptFile{

	NSString * _key = @"key123";	

	NSData *plainData = [self AES256DecryptFileWithKey:_key];
	NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
	
	NSLog(@"Decrypt data: %@", plainString);
	
}

-(IBAction)encryptFile{
	
	NSString * str = @"key123";
	NSString * _key = @"key123";
	
	NSData *plainData = [str AES256EncryptFileWithKey:_key];
//	NSData *plainData = [self AESEncryptWithKey];
	NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
	
	NSLog(@"Encrypted data: %@", plainString);
	
}


//++++++++++++++++++++++
// AES Deccrypt
//++++++++++++++++++++++
- (NSString *)AESDecryptWithKey:(NSString *)key
{
	
	NSString *path1 = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"txt"];
    NSData *d = [NSData dataWithContentsOfFile:path1];
	
//	NSLog(@"Decrypt Path: %@", path1 );
//	NSLog(@"Before Decrypt Data: %@", d);
	
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES128+ 1]; // room for terminator (unused)
	bzero( keyPtr, sizeof( keyPtr ) ); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [d length];
	
	//See the doc: For block ciphers, the output size will always be less than or 
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc( bufferSize );
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt( kCCDecrypt, kCCAlgorithmAES128, kCCOptionECBMode,
                                          keyPtr, kCCKeySizeAES128,
                                          NULL /* initialization vector (optional) */,
                                          [d bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted );	
	
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"index.html"];

    if (cryptStatus == kCCSuccess) {
		NSData * output = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];

//		NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
//		NSData *plainData = [encryptedData AES256DecryptWithKey:key];
		
		NSString *plainString = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];		
		
		NSLog( @"Plain data: %@", plainString);
		
		NSLog(@"File : %@", filePath);		
		[output writeToFile:filePath options:NSDataWritingAtomic error:nil];
    }
//    if (html == nil) {
//        html = [NSString stringWithFormat:@"<html><body>%@ file corrupted</body></html>", path1];
//    }
	
	free(buffer);
	return nil;
	
}

//*******************

- (NSString *)AESEncryptWithKey:(NSString *)key
{
	
	NSString *path1 = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSData *d = [NSData dataWithContentsOfFile:path1];
	
	NSLog( @"Encrypt Path: %@", path1 );
	
	// 'key' should be 32 bytes for AES256, will be null-padded otherwise
	char keyPtr[kCCKeySizeAES256 + 1]; // room for terminator (unused)
	bzero( keyPtr, sizeof( keyPtr ) ); // fill with zeroes (for padding)
	
	// fetch key data
	[key getCString:keyPtr maxLength:sizeof( keyPtr ) encoding:NSUTF8StringEncoding];
	
	NSUInteger dataLength = [d length];
	
	//See the doc: For block ciphers, the output size will always be less than or 
	//equal to the input size plus the size of one block.
	//That's why we need to add the size of one block here
	size_t bufferSize = dataLength + kCCBlockSizeAES128;
	void *buffer = malloc( bufferSize );
	
	size_t numBytesEncrypted = 0;
	CCCryptorStatus cryptStatus = CCCrypt( kCCEncrypt, kCCAlgorithmAES128, kCCOptionECBMode + kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [d bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted );
	NSLog(@"Length: %i", dataLength);

	
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"test.txt"];

	if( cryptStatus == kCCSuccess )
	{
		NSData * output = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
		NSLog(@"File : %s", filePath);		
		[output writeToFile:filePath options:NSDataWritingAtomic error:nil];
		

//		BOOL sucess = [output writeToFile:path1 atomically:YES options:NSDataWritingAtomic error:nil];  
//		if(!sucess)
//		{
//			NSLog(@"Could not to write to the file");
//		}		
		
		//the returned NSData takes ownership of the buffer and will free it on deallocation
		//return output;
	}
	
	free(buffer);
	return nil;
}

//------------------------
// AES Encrypt End
//------------------------


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
