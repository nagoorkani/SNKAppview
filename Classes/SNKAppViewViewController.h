//
//  SNKAppViewViewController.h
//  SNKAppView
//
//  Created by Nagoor Kani Sheik Maideen on 4/29/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface SNKAppViewViewController : UIViewController {

	IBOutlet UITextField *txtName;
	IBOutlet UIButton *btnDisplay;
	IBOutlet UILabel *lblPrint;
	IBOutlet UISlider *sliderValue;
	IBOutlet UISwitch *switchColor;
	IBOutlet UIButton *btnEncrypt;
	IBOutlet UIButton *btnDecrypt;
	IBOutlet UIButton *btnFileDecrypt;
	IBOutlet UIButton *btnFileEncrypt;
	
}

-(IBAction)displayText;
-(IBAction)sliderChanged;
-(IBAction)changeBGColor;
-(IBAction)encryptValue;
-(IBAction)decryptValue;
-(IBAction)decryptFile;
-(IBAction)encryptFile;

- (NSString *)AESEncryptWithKey:(NSString *)key;
- (NSString *)AESDecryptWithKey:(NSString *)key;

@end

