//
//  WalletMakerView.m
//  AirBitz
//
//  Created by Carson Whitsett on 4/4/14.
//  Copyright (c) 2014 AirBitz. All rights reserved.
//

#import "WalletMakerView.h"
#import "ABC.h"
#import "User.h"
#import "CommonTypes.h"
#import "OfflineWalletViewController.h"
#import "Util.h"

@interface WalletMakerView () <ButtonSelectorDelegate, UITextFieldDelegate>
{
    BOOL                        _bCreatingWallet;
	CGRect                      _originalFrame;
    int                         _currencyChoice;
}

@property (weak, nonatomic) IBOutlet UIImageView            *imageEditBox;
@property (nonatomic, weak) IBOutlet ButtonSelectorView     *buttonSelectorView;
@property (weak, nonatomic) IBOutlet UILabel                *labelOnline;
@property (weak, nonatomic) IBOutlet UILabel                *labelOffline;
@property (weak, nonatomic) IBOutlet UISwitch               *switchOnlineOffline;
@property (weak, nonatomic) IBOutlet UIView                 *viewBlocker;

@property (nonatomic, strong)   NSArray                     *arrayCurrencyNums;
@property (nonatomic, strong)   NSArray                     *arrayCurrencyCodes;
@property (nonatomic, copy)     NSString                    *strReason;
@property (nonatomic, assign)   BOOL                        bSuccess;


@end

@implementation WalletMakerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
	{
		UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"WalletMakerView~iphone" owner:self options:nil] objectAtIndex:0];
		view.frame = self.bounds;
        [self addSubview:view];

        self.textField.delegate = self;
		self.buttonSelectorView.delegate = self;

        _bCreatingWallet = NO;
		
		_originalFrame = self.frame;
		
		tABC_Currency *currencyArray;
		tABC_Error error;
		int numCurrencies;
		tABC_CC result = ABC_GetCurrencies(&currencyArray, &numCurrencies, &error);
		if(result == ABC_CC_Ok)
		{
			/*
			 typedef struct sABC_Currency
			 {
			 char    *szCode;		// currency ISO 4217 code
			 int     num;			// currency ISO 4217 num
			 char    *szDescription; // currency description
			 char    *szCountries;	// currency countries
			 } tABC_Currency;
			 */

            NSMutableArray *arrayCurrencyCodes = [[NSMutableArray alloc] init];
            NSMutableArray *arrayCurrencyNums = [[NSMutableArray alloc] init];
			NSMutableArray *arrayCurrencyStrings = [[NSMutableArray alloc] init];
			for(int i = 0; i < numCurrencies; i++)
			{
				//populate with currency code and description
				[arrayCurrencyStrings addObject:[NSString stringWithFormat:@"%s - %@", currencyArray[i].szCode, [NSString stringWithUTF8String:currencyArray[i].szDescription]]];

                [arrayCurrencyNums addObject:[NSNumber numberWithInt:currencyArray[i].num]];
                [arrayCurrencyCodes addObject:[NSString stringWithUTF8String:currencyArray[i].szCode]];
			}

			self.buttonSelectorView.arrayItemsToSelect = arrayCurrencyStrings;
            self.arrayCurrencyNums = arrayCurrencyNums;
            self.arrayCurrencyCodes = arrayCurrencyCodes;
		}

        [self reset];
    }
    return self;
}

#pragma mark - Action Methods

- (IBAction)switchValueChanged:(id)sender
{
    [self.buttonSelectorView close];
    [self.textField resignFirstResponder];
    [self updateDisplay];
    if ([self onlineSelected])
    {
        [self.textField becomeFirstResponder];
    }
}

- (IBAction)buttonOnlineTouched:(id)sender
{
    [self.switchOnlineOffline setOn:NO animated:YES];
    [self updateDisplay];
    if ([self onlineSelected])
    {
        [self.textField becomeFirstResponder];
    }
}

- (IBAction)buttonOfflineTouched:(id)sender
{
    [self.switchOnlineOffline setOn:YES animated:YES];
    [self updateDisplay];
}

- (IBAction)buttonCancelTouched:(id)sender
{

    [self exit];
}

- (IBAction)buttonDoneTouched:(id)sender
{
    [self createWallet];
}

#pragma mark - Public Methods

- (void)reset
{
    CGRect frame = self.viewBlocker.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    self.viewBlocker.hidden = YES;
    [self.textField resignFirstResponder];
    self.textField.text = @"";
    [self.switchOnlineOffline setOn:NO];
    [self.buttonSelectorView close];
    self.buttonSelectorView.textLabel.text = NSLocalizedString(@"Currency:", @"name of button on wallets view");
	[self.buttonSelectorView.button setTitle:@"USD" forState:UIControlStateNormal];
    _currencyChoice = (int) [self.arrayCurrencyCodes indexOfObject:@"USD"];
    [self updateDisplay];
}

#pragma mark - Misc Methods

- (void)updateDisplay
{
    if ([self onlineSelected])
    {
        self.buttonSelectorView.hidden = NO;
        self.textField.hidden = NO;
        self.imageEditBox.hidden = NO;
        self.labelOffline.textColor = [UIColor darkGrayColor];
        self.labelOnline.textColor = [UIColor whiteColor];
    }
    else
    {
        self.buttonSelectorView.hidden = YES;
        self.textField.hidden = YES;
        self.imageEditBox.hidden = YES;
        self.labelOnline.textColor = [UIColor darkGrayColor];
        self.labelOffline.textColor = [UIColor whiteColor];
    }
}

- (BOOL)onlineSelected
{
    return ![self.switchOnlineOffline isOn];
}

- (void)createWallet
{
    if ([self onlineSelected])
    {
        if (self.textField.text)
        {
            if ([self.textField.text length])
            {
                [self createOnlineWallet];
                [self exit];
            }
        }
    }
    else
    {
        [self createOfflineWallet];
    }
}

- (void)createOnlineWallet
{
    tABC_CC result;
	tABC_Error Error;

    //NSLog(@"creating wallet: %s with currency code: %d", [self.textField.text UTF8String], [[self.arrayCurrencyNums objectAtIndex:_currencyChoice] intValue]);
	result = ABC_CreateWallet([[User Singleton].name UTF8String],
                              [[User Singleton].password UTF8String],
                              [self.textField.text UTF8String],
                              [[self.arrayCurrencyNums objectAtIndex:_currencyChoice] intValue],
                              0,
                              ABC_Wallet_Maker_Request_Callback,
                              (__bridge void *)self,
                              &Error);
    [Util printABC_Error:&Error];

    if (result == ABC_CC_Ok)
    {
        [self blockUser:YES];
        _bCreatingWallet = YES;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:NSLocalizedString(@"Create Wallet", nil)
							  message:[NSString stringWithFormat:@"Wallet creation failed:\n%s", Error.szDescription]
							  delegate:nil
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		[alert show];
    }
}

- (void)createOfflineWallet
{
    if (!_bCreatingWallet)
    {
        [self.textField resignFirstResponder];
        [self.buttonSelectorView close];

        if (self.delegate)
        {
            if ([self.delegate respondsToSelector:@selector(walletMakerViewExitOffline:)])
            {
                [self.delegate walletMakerViewExitOffline:self];
            }
        }
    }
}

- (void)createWalletComplete
{
    [self blockUser:NO];
    _bCreatingWallet = NO;

    //NSLog(@"Wallet create complete");
    if (_bSuccess)
    {
        [self exit];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]
							  initWithTitle:NSLocalizedString(@"Create Wallet", nil)
							  message:[NSString stringWithFormat:@"Wallet creation failed:\n%@", _strReason]
							  delegate:nil
							  cancelButtonTitle:@"OK"
							  otherButtonTitles:nil];
		[alert show];
    }
}

- (void)blockUser:(BOOL)bBlock
{
    self.viewBlocker.hidden = !bBlock;
}

- (void)exit
{
    if (!_bCreatingWallet)
    {
        [self.textField resignFirstResponder];
        [self.buttonSelectorView close];

        if (self.delegate)
        {
            if ([self.delegate respondsToSelector:@selector(walletMakerViewExit:)])
            {
                [self.delegate walletMakerViewExit:self];
            }
        }
    }
}

#pragma mark - ButtonSelector Delegates

-(void)ButtonSelector:(ButtonSelectorView *)view selectedItem:(int)itemIndex
{
    _currencyChoice = itemIndex;
}

-(NSString *)ButtonSelector:(ButtonSelectorView *)view willSetButtonTextToString:(NSString *)desiredString
{
	NSString *result = [[desiredString componentsSeparatedByString:@" - "] firstObject];
	return result;
}

- (void)ButtonSelectorWillShowTable:(ButtonSelectorView *)view
{
    [self.textField resignFirstResponder];
}

#pragma mark - UITextField delegates

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.buttonSelectorView close];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!_bCreatingWallet)
    {
        [textField resignFirstResponder];

        [self createWallet];
    }

	return YES;
}

void ABC_Wallet_Maker_Request_Callback(const tABC_RequestResults *pResults)
{
    //NSLog(@"Request callback");

    if (pResults)
    {
        WalletMakerView *controller = (__bridge id)pResults->pData;
        controller.bSuccess = (BOOL)pResults->bSuccess;
        controller.strReason = [NSString stringWithFormat:@"%s", pResults->errorInfo.szDescription];
        if (pResults->requestType == ABC_RequestType_CreateWallet)
		{
			if (pResults->pRetData)
            {
                //controller.strWalletUUID = [NSString stringWithFormat:@"%s", (char *)pResults->pRetData];
                free(pResults->pRetData);
            }
            else
            {
                //controller.strWalletUUID = @"(Unknown UUID)";
            }
            //NSLog(@"Create wallet completed with cc: %ld (%s)", (unsigned long) pResults->errorInfo.code, pResults->errorInfo.szDescription);
            [controller performSelectorOnMainThread:@selector(createWalletComplete) withObject:nil waitUntilDone:FALSE];
		}
    }
}

@end
