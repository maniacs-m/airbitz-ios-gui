//
//  Strings.m
//  Airbitz
//
//  Created by Paul P on 1/3/16.
//  Copyright © 2016 Airbitz. All rights reserved.
//

#define backButtonText                              NSLocalizedString(@"Back", @"Back button text on top left")
#define exitButtonText                              NSLocalizedString(@"Exit", @"Exit button text on top left")
#define helpButtonText                              NSLocalizedString(@"Help", @"Help button text on top right")
#define infoButtonText                              NSLocalizedString(@"Info", @"Info button text on top right")
#define doneButtonText                              NSLocalizedString(@"Done", @"Generic DONE button text")
#define cancelButtonText                            NSLocalizedString(@"CANCEL", @"Generic CANCEL button text")
#define goBackButtonText                            NSLocalizedString(@"Go Back", @"Generic Go Back button text")
#define closeButtonText                             NSLocalizedString(@"Close", @"Generic CLOSE button text")
#define shareButtonText                             NSLocalizedString(@"Share", @"Generic SHARE button text")
#define exportButtonText                            NSLocalizedString(@"Export", @"EXPORT button text for wallet export")
#define renameButtonText                            NSLocalizedString(@"Rename", @"RENAME button text for wallet rename")
#define deleteButtonText                            NSLocalizedString(@"Delete", @"DELETE button text for wallet delete")
#define okButtonText                                NSLocalizedString(@"OK", @"OK button text")
#define copyButtonText                              NSLocalizedString(@"Copy", @"Copy button text")
#define skipButtonText                              NSLocalizedString(@"Skip", @"Skip button text")
#define nextButtonText                              NSLocalizedString(@"Next", @"Next button text")
#define laterButtonText                             NSLocalizedString(@"Later", @"Later button text")
#define noButtonText                                NSLocalizedString(@"NO", @"NO button text")
#define yesButtonText                               NSLocalizedString(@"YES", @"YES button text")
#define changeButtonText                            NSLocalizedString(@"CHANGE", @"CHANGE button text")
#define checkPasswordButtonText                     NSLocalizedString(@"Check Password", @"Check password button text")
#define walletBalanceHeaderText                     NSLocalizedString(@"TOTAL: ", @"Prefix of wallet balance dropdown header")
#define walletNameHeaderText                        NSLocalizedString(@"Wallet: ", @"Prefix of wallet name on rename popup")
#define renameWalletWarningText                     NSLocalizedString(@"Wallet name must have at least one character", nil)
#define transactionCellNoTransactionsText           NSLocalizedString(@"No Transactions", @"what to display when wallet has no transactions")
#define transactionCellNoTransactionsFoundText      NSLocalizedString(@"No Transactions Found", @"what to display when no transactions are found in search")
#define fiatText                                    NSLocalizedString(@"Fiat", @"Fiat")
#define walletHeaderButtonHelpText                  NSLocalizedString(@"To sort wallets, tap and drag the 3 bars to the right of a wallet. Drag below the [ARCHIVE] header to archive the wallet", @"Popup wallet help test")
#define walletHasBeenArchivedText                   NSLocalizedString(@"This wallet has been archived. Please select a different wallet from the [Wallets] screen", @"Popup sessage for when a wallet is archived")
#define walletsPopupHelpText                        NSLocalizedString(@"Tap and hold a wallet for additional options", nil)
#define selectWalletTransferPopupHeaderText         NSLocalizedString(@"▼ Choose a wallet to transfer funds to ▼", @"Header of popup in SendView from wallet to wallet transfer")
#define invalidAddressPopupText                     NSLocalizedString(@"Invalid Bitcoin Address", nil)
#define enterBitcoinAddressPopupText                NSLocalizedString(@"Send to Bitcoin Address or Import Private Key", nil)
#define deleteAccountText                           NSLocalizedString(@"Delete Account", nil)
#define deleteAccountWarning                        NSLocalizedString(@"Delete '%@' on this device? This will disable access via PIN. If 2FA is enabled on this account, this device will not be able to login without a 2FA reset which takes 7 days.", @"Delete Account Warning")
#define deleteAccountNoPasswordWarningText          NSLocalizedString(@"Delete '%@' on this device? This account has no password and will NOT BE RECOVERABLE if you delete it.", @"Delete Account With no Password Warning")
#define enterBitcoinAddressPlaceholder              NSLocalizedString(@"Bitcoin Address or Private Key", nil)
#define enterPrivateKeyPopupText                    NSLocalizedString(@"Sweep Funds From Private Key", nil)
#define enterPrivateKeyPlaceholder                  NSLocalizedString(@"Bitcoin Private Key", nil)
#define smsText                                     NSLocalizedString(@"SMS", @"text for textmessage/SMS")
#define emailText                                   NSLocalizedString(@"Email", @"text for Email")
#define sendScreenHelpText                          NSLocalizedString(@"Scan the QR code of payee to send payment or tap on a bluetooth request from the list below", nil)
#define creatingWalletText                          NSLocalizedString(@"Creating and securing wallet", nil)
#define createAccountAndTransferFundsText           NSLocalizedString(@"Please create a new account and transfer your funds if you forgot your password.", nil)
#define createPasswordForAccountText                NSLocalizedString(@"Please create a password for this account or you will not be able to recover your account if your device is lost or stolen.", nil)
#define settingsText                                NSLocalizedString(@"Settings", nil)
#define categoriesText                              NSLocalizedString(@"Categories", nil)
#define signupText                                  NSLocalizedString(@"Sign Up", nil)
#define changePasswordText                          NSLocalizedString(@"Change Password", nil)
#define changePINText                               NSLocalizedString(@"Change PIN", nil)
#define twoFactorText                               NSLocalizedString(@"Two Factor", nil)
#define importText                                  NSLocalizedString(@"Import", nil)
#define buySellText                                 NSLocalizedString(@"Buy/Sell Bitcoin", nil)
#define discountedGiftCardsText                     NSLocalizedString(@"Discounted Gift Cards", nil)
#define passwordRecoveryText                        NSLocalizedString(@"Password Recovery", nil)
#define passwordMismatchText                        NSLocalizedString(@"Password does not match re-entered password", @"")
#define defaultCurrencyInfoText                     NSLocalizedString(@"Note: Default Currency setting is only used for new wallets and to show total balance of account. Create a new wallet to change the fiat currency shown in each transaction.", nil)
#define touchIDPromptText                           NSLocalizedString(@"Touch to login user", @"Touch ID prompt text")
#define usePINText                                  NSLocalizedString(@"Use PIN", @"Touch ID [Use PIN] button")
#define usePasswordText                             NSLocalizedString(@"Use Password", @"Touch ID [Use Password] button")
#define twofactorWarningText                        NSLocalizedString(@"Two Factor Enabled\n\n** Warning **\n\nIf you lose your device or uninstall the app, it will take 7 days to disable 2FA and access your account.\"", @"2FA warning on enable")
#define loadingAccountText                          NSLocalizedString(@"Loading Account...", @"Loading account alert text")
#define loadingWalletsText                          NSLocalizedString(@"Loading Wallets...", @"Loading wallets alert text")
#define fetchingPaymentRequestText                  NSLocalizedString(@"Fetching Payment Request...", @"Fetching Payment Request popup")
#define loadingWalletsNewDeviceText                 NSLocalizedString(@"This may take a few minutes if it is the first time logging into this device.", @"Loading Wallets alert text")
#define loadingTransactionsText                     NSLocalizedString(@"Loading Transactions...", @"Loading Transactions alert text")
#define synchronizingText                           NSLocalizedString(@"Synchronizing", @"Synchronizing text in confirmation textfield")
#define pendingText                                 NSLocalizedString(@"Pending", @"Pending status in transaction list")
#define doubleSpendText                             NSLocalizedString(@"Warning: Double Spend", @"Double spend status in transaction list")
#define confirmationText                            NSLocalizedString(@"Confirmation", @"Num of confirmations in transaction list")
#define confirmationsText                           NSLocalizedString(@"Confirmations", @"Num of confirmations in transaction list")
#define confirmedText                               NSLocalizedString(@"Confirmed", @"Confirmed status in transaction list")
#define loadingText                                 NSLocalizedString(@"Loading", @"Loading...")
#define uploadLogFileText                           NSLocalizedString(@"Upload Log File", nil)
#define enterAnyNotesForSupportStaff                NSLocalizedString(@"Enter any notes you would like to send to our support staff", nil)
#define uploadLogText                               NSLocalizedString(@"Upload Log", nil)
#define uploadingLogText                            NSLocalizedString(@"Uploading logfile. Please wait...", @"Uploading logfile fading popup")
#define uploadSuccessfulText                        NSLocalizedString(@"Upload Successful", @"Upload Successful fading popup")
#define uploadFailedText                            NSLocalizedString(@"Upload Failed", @"Upload Failed")
#define watcherClearedText                          NSLocalizedString(@"Watcher Database Cleared. Please allow a few minutes to resync blockchain info. Transactions and balances may be inaccurate during sync", @"Watcher Database Cleared popup text")
#define watcherClearedWithErrorText                 NSLocalizedString(@"Watcher Database Cleared But Error Occurred. Please allow a few minutes to resync blockchain info. Transactions and balances may be inaccurate during sync", @"Watcher Database Cleared popup text")
#define PINOnlyNumbersText                          NSLocalizedString(@"Only numbers allowed in PIN", @"")
#define scanQrToSendFundsText                       NSLocalizedString(@"Scan QR to Send/Sweep or Login with BitID", @"Text at top of Send screen")
#define scanQrToImportPrivateKeyOrGiftCard          NSLocalizedString(@"Scan QR to Import Private Key/Gift Card", @"Text at top of Scan Screen")
#define signupUsernameText                          NSLocalizedString(@"This is not your email or real name.\n\nThis is the username to login into your [[abtag APP_TITLE]] account on this and other devices.\n\nYour username and password are known only to you and never stored unencrypted.", "Username Signup screen info text")
#define signupCameraText                            NSLocalizedString(@"You will next see a popup requesting access to your Camera.\n\n[[abtag APP_TITLE]] needs this to scan QR codes to pay people and merchants.",@"Camera signup screen")
#define signupContactsText                          NSLocalizedString(@"[[abtag APP_TITLE]] uses contacts to help tag information regarding your transactions.\n\nAll tagged information is kept 100% private and encrypted by your password.\n\nNo one, including [[abtag APP_TITLE]], has any access to this information.",@"Contacts signup screen")
#define importPrivateKeyText                        NSLocalizedString(@"IMPORT PRIVATE KEY\n([[abtag APP_TITLE]] Gift Card)", @"Slideout menu import private key text")
#define giftCardText                                NSLocalizedString(@"DISCOUNTED GIFT CARDS", @"Slideout menu gift card text")
#define bitcoinWalletTransactionsText               NSLocalizedString(@"Bitcoin Wallet Transactions", @"Export wallet transactions email subject line")
#define accountsNeedsPasswordNotificationTitle      NSLocalizedString(@"WARNING: missing password", @"Title of missing password notification")
#define accountsNeedsPasswordNotificationMessage    NSLocalizedString(@"Account '%@' needs a password. Account is not accessible on a new device without a password.", nil)
#define renameWalletText                            NSLocalizedString(@"Rename Wallet", @"Rename Wallet popup")
#define deleteWalletText                            NSLocalizedString(@"Delete Wallet", @"Delete Wallet popup")
#define deleteWalletWarningText                     NSLocalizedString(@"Are you sure? You will be unable to access any funds in this wallet and any future funds that it may receive", nil)
#define deleteWalletHasFunds                        NSLocalizedString(@"Cannot delete wallet as it contains funds. Please transfer out funds first.",nil)
#define deletingWalletText                          NSLocalizedString(@"Deleting Wallet", @"Text for popup while deleting wallet")
#define deleteWalletErrorText                       NSLocalizedString(@"Error Deleting Wallet",nil)
#define deleteWalletDeletedText                     NSLocalizedString(@"Wallet Deleted",nil)
#define rememberYourPasswordText                    NSLocalizedString(@"Remember your password?", nil)
#define rememberYourPasswordWarningText             NSLocalizedString(@"Do you still remember your password? You will need your password if your device gets lost or stolen, or if you uninstall the app.\nEnter it below to make sure:", nil)
#define greatJobRememberingPasswordText             NSLocalizedString(@"Great job remembering your password.", nil)
#define incorrectPasswordText                       NSLocalizedString(@"Incorrect Password", nil)
#define incorrectPasswordTryAgainText               NSLocalizedString(@"Incorrect Password. Try again, or change it now?", nil)
#define howAreYouLikingAirbitzText                  NSLocalizedString(@"How are you liking %@?", @"Like Airbitz popup")
#define notSoGoodText                               NSLocalizedString(@"Not so good", nil)
#define itsGreatText                                NSLocalizedString(@"It's great", nil)
#define receivedFundsText                           NSLocalizedString(@"Received Funds", nil)
#define bitcoinReceivedTapText                      NSLocalizedString(@"%@ Bitcoin received. Tap for details.", nil)
#define youReceivedBitcoinText                      NSLocalizedString(@"You Received Bitcoin!\n%@ (~%@)", nil)
#define youReceivedBitcoinUsePayeeText              NSLocalizedString(@"You received Bitcoin!\n%@ (~%@)\nUse the Payee, Category, and Notes field to optionally tag your transaction", nil)
#define wouldYouLikeToSendFeedbackText              NSLocalizedString(@"Would you like to send us some feedback?", nil)
#define noThanksText                                NSLocalizedString(@"No thanks", nil)
#define wouldYouLikeToWriteReviewText               NSLocalizedString(@"Would you like to write a review in the App store?", nil)
#define cantSendEmailText                           NSLocalizedString(@"Can't send e-mail",nil)
#define navbarToWalletPrefixText                    NSLocalizedString(@"To: %@ ▼", "Top of screen wallet dropdown prefix text")
#define setPasswordAndPinText                       NSLocalizedString(@"Set a Password and PIN",nil)
#define setPasswordText                             NSLocalizedString(@"Set a Password",nil)
#define warningWithoutPasswordTitleText             NSLocalizedString(@"Account has no password",nil)
#define warningWithoutPasswordPopupText             NSLocalizedString(@"Warning. Without a password, you will not be able to login on a new device if this device is lost or stolen, or if this app is uninstalled", nil)
#define errorRecoveringAccountTitle                 NSLocalizedString(@"Error Recovering Account",nil)
#define errorRecoveringAccountText                  NSLocalizedString(@"Please try again later or contact support",nil)
#define setRecoveryQuestionsFailed                  NSLocalizedString(@"Setting recovery questions failed:\n%@", nil)
#define recoveryQuestionsNotSet                     NSLocalizedString(@"Recovery Questions Not Set", @"Title of recovery questions setup error alert")
#define recoveryQuestionsSet                        NSLocalizedString(@"Recovery Questions Set", @"Title of recovery questions setup complete alert")
#define recoveryQuestionsSetWarning                 NSLocalizedString(@"Your password recovery questions and answers are now set up.  When recovering your password, your answers must match exactly. **DO NOT FORGET YOUR PASSWORD AND RECOVERY ANSWERS** YOUR ACCOUNT CANNOT BE RECOVERED WITHOUT THEM!!",nil)
#define defaultWalletName                           NSLocalizedString(@"My Wallet", @"Default wallet name for new accounts")
#define errorGettingWalletCount                     NSLocalizedString(@"Error Getting Wallet Count", nil)
#define generatingQRCode                            NSLocalizedString(@"Generating QR Code...", nil)
#define imagePickerAlertTitle                       NSLocalizedString(@"Upload Image", nil)
#define imagePickerAlertUseCamera                   NSLocalizedString(@"Use Camera", nil)
#define imagePickerAlertUsePhotos                   NSLocalizedString(@"Use Photo Album", nil)
#define yourPasswordText                            NSLocalizedString(@"Your password...", @"Start of password rules text")
#define mustHaveUpperCase                           NSLocalizedString(@"Must have at least one upper case letter",nil)
#define mustHaveLowerCase                           NSLocalizedString(@"Must have at least one lower case letter",nil)
#define mustHaveNumber                              NSLocalizedString(@"Must have at least one number",nil)
#define mustHaveMoreCharacters                      NSLocalizedString(@"Must have at least %d characters",nil)
#define bitcoinPrivateKeyText                       NSLocalizedString(@"Bitcoin Private Key with Public Address", nil)
#define bitIDLogin                                  NSLocalizedString(@"BitID Login", nil)
#define wouldYouLikeToSendOrImport                  NSLocalizedString(@"Would you like to send funds to this address or import funds into your wallet?", nil)
#define importFunds                                 NSLocalizedString(@"Import Funds",nil)
#define sendFundsToPrivateKey                       NSLocalizedString(@"Send Funds to Private Key",nil)
#define balanceButtonText                           NSLocalizedString(@"Balance", nil)
#define transferToWalletText                        NSLocalizedString(@"Transfer To %@", @"To wallet transfer text")
#define transferFromWalletText                      NSLocalizedString(@"Transfer From %@", @"From wallet transfer text")
#define transferCategoryText                        NSLocalizedString(@"Transfer:Wallet:%@", @"Wallet transfer category")
#define incomeAffiliateRevenue                      NSLocalizedString(@"Income:Affiliate Revenue", @"Income category for affiliate revenue")
#define notesAffiliateRevenue                       NSLocalizedString(@"Revenue share from affiliate link %@", @"Income notes field for affiliate revenue")
#define debugButtonText                             NSLocalizedString(@"Debug", @"debug text")
#define getAffiliateLinkButtonText                  NSLocalizedString(@"Get Affiliate Link", @"Button text for Get Affiliate Link")
#define requestIsCopiedToClipboardText              NSLocalizedString(@"Request is copied to the clipboard", nil)
#define affiliateLinkIsCopiedToClipboardText        NSLocalizedString(@"Affiliate link has been copied to the clipboard", nil)
#define shareThisLinkAndReceiveRevenue              NSLocalizedString(@"%@\n\nShare this link to receive revenue from users that install and use %@. You will receive 0.25%% of all gift card purchases made inside of this app.", nil)
#define affiliateLinkShareText                      NSLocalizedString(@"Download the Airbitz wallet and save money using bitcoin", nil)
#define messageSentText                             NSLocalizedString(@"Message Sent", nil)
#define answersAreCaseSensitiveText                 NSLocalizedString(@"Answers are case sensitive", @"Warning for password recovery textfields")
#define autoLogoffAfterText                         NSLocalizedString(@"Auto log off after", @"settings text")
#define defaultCurrencyText                         NSLocalizedString(@"Default Currency", @"settings text")
#define defaultExchangeText                         NSLocalizedString(@"Default Exchange", @"settings text")
#define buyBitcoinButton                            NSLocalizedString(@"Buy Bitcoin",nil)
#define importAirbitzGiftCardButton                 NSLocalizedString(@"Import Airbitz Gift Card",nil)
#define upTo20OffStarbucksTargetButton              NSLocalizedString(@"Up to 20% off Starbucks & Target",nil)
#define upTo15to20OffAmazonButton                   NSLocalizedString(@"15-20% off Amazon",nil)
#define importPrivateKeyButton                      NSLocalizedString(@"Import Private Key", nil)
#define debugOptionsTitle                           NSLocalizedString(@"Debug Options", @"Debug screen header title")
#define restartingWatcherServiceText                NSLocalizedString(@"Restarting watcher service", nil)
#define noPasswordSetText                           NSLocalizedString(@"No password set", nil)
#define passwordChangeText                          NSLocalizedString(@"Password Change", nil)
#define passwordToAccountChangeText                 NSLocalizedString(@"The password to this account was changed by another device. Please login using the new credentials.", nil)
#define tfaOnText                                   NSLocalizedString(@"Two Factor Authentication On", nil)
#define tfaEnabledFromDifferentDeviceText           NSLocalizedString(@"Two Factor Authentication (enchanced security) has been enabled from a different device for this account. Please enable 2 Factor Authentication for full access from this device.", nil)
#define remindMeLaterText                           NSLocalizedString(@"Remind Me Later", nil)
#define enableButtonText                            NSLocalizedString(@"Enable", nil), nil]
#define tfaInvalidText                              NSLocalizedString(@"Two Factor Invalid", nil)
#define tfaTokenOnThisDeviceInvalidText             NSLocalizedString(@"The Two Factor Authentication token on this device is invalid. Either the token was changed by a different device our your clock is skewed. Please check your system time to ensure it is correct.", nil)
#define checkingPasswordText                        NSLocalizedString(@"Checking password...", nil)