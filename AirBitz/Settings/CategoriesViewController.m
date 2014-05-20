//
//  CategoriesViewController.m
//  AirBitz
//
//  Created by Carson Whitsett on 4/1/14.
//  Copyright (c) 2014 AirBitz. All rights reserved.
//

#import "CategoriesViewController.h"
#import "CommonTypes.h"
#import "CategoriesCell.h"
#import "ABC.h"
#import "User.h"
#import "PickerTextView.h"
#import "Util.h"

#define BOTTOM_BUTTON_EXTRA_OFFSET_Y    3
#define TABLE_SIZE_EXTRA_HEIGHT         5

#define ARRAY_CATEGORY_PREFIXES         @[@"Expense:",@"Income:",@"Transfer:"]

#define PICKER_MAX_CELLS_VISIBLE        (IS_IPHONE5 ? 3 : 2)

#define POS_THRESHOLD_TO_GET_3_CHOICES  180.0

@interface CategoriesViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UITextFieldDelegate, CategoriesCellDelegate, PickerTextViewDelegate>
{
    char            **_aszCategories;
    unsigned int    _count;
}

@property (nonatomic, weak) IBOutlet    UITableView     *tableView;
@property (nonatomic, weak) IBOutlet    UIButton        *cancelButton;
@property (nonatomic, weak) IBOutlet    UIButton        *doneButton;
@property (weak, nonatomic) IBOutlet    UIImageView     *imageBottomBar;
@property (weak, nonatomic) IBOutlet    PickerTextView  *pickerTextNew;
@property (weak, nonatomic) IBOutlet    UITextField     *textSearch;

@property (nonatomic, strong)           NSMutableArray  *arrayCategories;
@property (nonatomic, strong)           NSMutableArray  *arrayDisplay;
@property (nonatomic, strong)           NSArray         *arrayDisplayPositions;

@end

@implementation CategoriesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self.cancelButton setTitle:NSLocalizedString(@"Cancel", @"cancel button title") forState:UIControlStateNormal];
	[self.doneButton setTitle:NSLocalizedString(@"Done", @"done button title") forState:UIControlStateNormal];

    CGRect frame;

    // change bottom bar to right above tab bar
    frame = self.imageBottomBar.frame;
    frame.origin.y = SCREEN_HEIGHT - TOOLBAR_HEIGHT - self.imageBottomBar.frame.size.height;
    self.imageBottomBar.frame = frame;

    // change the bottom buttons to center in the bottom bar
    frame = self.cancelButton.frame;
    frame.origin.y = self.imageBottomBar.frame.origin.y + ((self.imageBottomBar.frame.size.height - self.cancelButton.frame.size.height) / 2.0) + BOTTOM_BUTTON_EXTRA_OFFSET_Y;
    self.cancelButton.frame = frame;
    frame = self.doneButton.frame;
    frame.origin.y = self.imageBottomBar.frame.origin.y + ((self.imageBottomBar.frame.size.height - self.doneButton.frame.size.height) / 2.0) + BOTTOM_BUTTON_EXTRA_OFFSET_Y;
    self.doneButton.frame = frame;

    // change the height of the table view
    frame = self.tableView.frame;
    frame.size.height = self.imageBottomBar.frame.origin.y - self.tableView.frame.origin.y + TABLE_SIZE_EXTRA_HEIGHT;
    self.tableView.frame = frame;

    // This will remove extra separators from tableview
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    // make the seperator go across the entire row
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    // load the categories
    [self loadCategories];

    // get a callback when the search changes
    [self.textSearch addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    // set up the specifics on our picker text view
    self.pickerTextNew.textField.returnKeyType = UIReturnKeyDone;
    self.pickerTextNew.textField.placeholder = NSLocalizedString(@"Add New", nil);
    self.pickerTextNew.textField.borderStyle = UITextBorderStyleNone;
    self.pickerTextNew.textField.backgroundColor = [UIColor clearColor];
    self.pickerTextNew.textField.font = [UIFont systemFontOfSize:14];
    self.pickerTextNew.textField.clearButtonMode = UITextFieldViewModeAlways;
    self.pickerTextNew.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.pickerTextNew.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.pickerTextNew.textField.spellCheckingType = UITextSpellCheckingTypeNo;
    [self.pickerTextNew setTopMostView:self.view];
    self.pickerTextNew.pickerMaxChoicesVisible = PICKER_MAX_CELLS_VISIBLE;
    self.pickerTextNew.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self freeStringArray:_aszCategories count:_count];
}

#pragma mark - Action Methods

- (IBAction)AddCategory
{
    [self resignAllResponders];

    if (self.pickerTextNew.textField.text)
    {
        if ([self.pickerTextNew.textField.text length])
        {
            [self.arrayCategories addObject:self.pickerTextNew.textField.text];
            [self updateDisplay];
        }
    }
}

- (IBAction)Cancel
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"Cancel Changes", nil)
                          message:NSLocalizedString(@"Are you sure you want to cancel any changes you've made?", nil)
                          delegate:self
                          cancelButtonTitle:@"No"
                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (IBAction)Done
{
    [self saveCategories];
    [self animatedExit];
}

#pragma mark - Misc Methods

- (CategoriesCell *)getCategoriesCellForTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath
{
	CategoriesCell *cell;
	static NSString *cellIdentifier = @"CategoriesCell";

	cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (nil == cell)
	{
		cell = [[CategoriesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
	}

	cell.delegate = self;

    cell.pickerTextView.textField.returnKeyType = UIReturnKeyDone;
    cell.pickerTextView.textField.borderStyle = UITextBorderStyleNone;
    cell.pickerTextView.textField.backgroundColor = [UIColor clearColor];
    cell.pickerTextView.textField.font = [UIFont systemFontOfSize:14];
    cell.pickerTextView.textField.clearButtonMode = UITextFieldViewModeAlways;
    cell.pickerTextView.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    cell.pickerTextView.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    cell.pickerTextView.textField.spellCheckingType = UITextSpellCheckingTypeNo;
    [cell.pickerTextView setTopMostView:self.view];
    cell.pickerTextView.pickerMaxChoicesVisible = PICKER_MAX_CELLS_VISIBLE;
    cell.pickerTextView.popupPickerPosition = PopupPickerPosition_Above;

    cell.tag = indexPath.row;

    cell.pickerTextView.textField.text = [self.arrayDisplay objectAtIndex:indexPath.row];

	return cell;
}

// load the categories from the core
- (void)loadCategories
{
    _aszCategories = NULL;
    _count = 0;

    // get the categories from the core
    tABC_Error Error;
    ABC_GetCategories([[User Singleton].name UTF8String],
                      &_aszCategories,
                      &_count,
                      &Error);
    [Util printABC_Error:&Error];

    // store them in our own array
    self.arrayCategories = [[NSMutableArray alloc] init];
    if (_aszCategories)
    {
        for (int i = 0; i < _count; i++)
        {
            [self.arrayCategories addObject:[NSString stringWithUTF8String:_aszCategories[i]]];
        }
    }

    [self updateDisplay];
}

// saves the categories to the core
- (void)saveCategories
{
    tABC_Error Error;

    // got through the existing categories
    for (int i = 0; i < _count; i++)
    {
        // create an NSString version of the category
        NSString *strCategory = [NSString stringWithUTF8String:_aszCategories[i]];

        // if this category is in our new list
        if ([self.arrayCategories containsObject:strCategory])
        {
            // remove it from our new list since it is already there
            [self.arrayCategories removeObject:strCategory];
        }
        else
        {
            // it doesn't exist in our new list so delete it from the core
            ABC_RemoveCategory([[User Singleton].name UTF8String], _aszCategories[i], &Error);
            [Util printABC_Error:&Error];
        }
    }

    // add any categories from our new list that didn't exist in the core list
    for (int i = 0; i < [self.arrayCategories count]; i++)
    {
        NSString *strCategory = [self.arrayCategories objectAtIndex:i];
        ABC_AddCategory([[User Singleton].name UTF8String], (char *)[strCategory UTF8String], &Error);
        [Util printABC_Error:&Error];
    }
}

- (void)updateDisplay
{
    NSString *strSearch = self.textSearch.text;

    // put those items in the display array that match the search criteria
    NSMutableArray *arrayDisplay = [[NSMutableArray alloc] init];
    NSMutableArray *arrayDisplayPositions = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.arrayCategories count]; i++)
    {
        NSString *strCategory = [self.arrayCategories objectAtIndex:i];

        // if our search string is in the category
        if (([strSearch length] == 0) ||
            ([strCategory rangeOfString:strSearch options:NSCaseInsensitiveSearch].location != NSNotFound))
        {
            [arrayDisplayPositions addObject:[NSNumber numberWithInt:i]];
            [arrayDisplay addObject:strCategory];
        }
    }

    self.arrayDisplayPositions = arrayDisplayPositions;
    self.arrayDisplay = arrayDisplay;

    [self.tableView reloadData];
}

// returns which prefix the given string starts with
// returns nil in none of them
- (NSString *)categoryPrefix:(NSString *)strCategory
{
    if (strCategory)
    {
        for (NSString *strPrefix in ARRAY_CATEGORY_PREFIXES)
        {
            if ([strCategory hasPrefix:strPrefix])
            {
                return strPrefix;
            }
        }
    }
    
    return nil;
}

- (NSArray *)createNewCategoryChoices:(NSString *)strVal
{
    NSMutableString *strCurVal = [[NSMutableString alloc] initWithString:@""];

    // put in what we have
    if (strVal)
    {
        if ([strVal length])
        {
            [strCurVal setString:strVal];
        }
    }

    // remove the prefix if it exists
    NSString *strPrefix = [self categoryPrefix:strCurVal];
    if (strPrefix)
    {
        [strCurVal setString:[strCurVal substringFromIndex:[strPrefix length]]];
    }

    // create the array of choices by adding the prefix to each one
    NSMutableArray *arrayChoices = [[NSMutableArray alloc] initWithCapacity:[ARRAY_CATEGORY_PREFIXES count]];
    for (NSString *strPrefix in ARRAY_CATEGORY_PREFIXES)
    {
        [arrayChoices addObject:[NSString stringWithFormat:@"%@%@", strPrefix, strCurVal]];
    }

    return arrayChoices;
}

- (void)forceCategoryFieldValue:(UITextField *)textField forPickerView:(PickerTextView *)pickerTextView
{
    NSMutableString *strNewVal = [[NSMutableString alloc] init];
    [strNewVal appendString:textField.text];

    NSString *strPrefix = [self categoryPrefix:textField.text];

    // if it doesn't start with a prefix, make it
    if (strPrefix == nil)
    {
        [strNewVal insertString:[ARRAY_CATEGORY_PREFIXES objectAtIndex:0] atIndex:0];
    }

    textField.text = strNewVal;

    NSArray *arrayChoices = [self createNewCategoryChoices:textField.text];

    [pickerTextView updateChoices:arrayChoices];
}

// resigns all the edit box responders
- (void)resignAllResponders
{
    [self.textSearch resignFirstResponder];
    [self.pickerTextNew.textField resignFirstResponder];
}

- (void)freeStringArray:(char **)aszStrings count:(unsigned int) count
{
    if ((aszStrings != NULL) && (count > 0))
    {
        for (int i = 0; i < count; i++)
        {
            free(aszStrings[i]);
        }
        free(aszStrings);
    }
}

- (void)animatedExit
{
	[UIView animateWithDuration:0.35
						  delay:0.0
						options:UIViewAnimationOptionCurveEaseInOut
					 animations:^
	 {
		 CGRect frame = self.view.frame;
		 frame.origin.x = frame.size.width;
		 self.view.frame = frame;
	 }
                     completion:^(BOOL finished)
	 {
		 [self exit];
	 }];
}

- (void)exit
{
	[self.delegate categoriesViewControllerDidFinish:self];
}

#pragma mark - UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 0;

    if (self.arrayDisplay)
    {
        count = [self.arrayDisplay count];
    }

    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 49.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell;

    cell = [self getCategoriesCellForTableView:tableView withIndexPath:indexPath];

	//cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	// if they said they wanted to exit without saving changes
	if (buttonIndex == 1)
	{
        [self performSelector:@selector(animatedExit) withObject:nil afterDelay:0.0];
	}
}

#pragma mark - UITextField delegates

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.textSearch)
    {
        [self updateDisplay];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.textSearch)
    {
        [self updateDisplay];
    }

	[textField resignFirstResponder];

	return YES;
}

#pragma mark - PickerTextView Delegates

- (BOOL)pickerTextViewFieldShouldChange:(PickerTextView *)pickerTextView charactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // create what the new value would look like
    NSString *strNewVal = [pickerTextView.textField.text stringByReplacingCharactersInRange:range withString:string];

    // if it still has a prefix
    if ([self categoryPrefix:strNewVal])
    {
        // allow it
        return YES;
    }

    return NO;
}

- (void)pickerTextViewFieldDidChange:(PickerTextView *)pickerTextView
{
    NSMutableString *strNewVal = [[NSMutableString alloc] init];
    [strNewVal appendString:pickerTextView.textField.text];

    NSString *strPrefix = [self categoryPrefix:pickerTextView.textField.text];

    // if it doesn't start with a prefix, make it
    if (strPrefix == nil)
    {
        [strNewVal insertString:[ARRAY_CATEGORY_PREFIXES objectAtIndex:0] atIndex:0];
    }

    pickerTextView.textField.text = strNewVal;

    NSArray *arrayChoices = [self createNewCategoryChoices:pickerTextView.textField.text];

    [pickerTextView updateChoices:arrayChoices];
}

- (void)pickerTextViewFieldDidBeginEditing:(PickerTextView *)pickerTextView
{
    [self forceCategoryFieldValue:pickerTextView.textField forPickerView:pickerTextView];
}

- (void)pickerTextViewFieldDidEndEditing:(PickerTextView *)pickerTextView
{
    [self forceCategoryFieldValue:pickerTextView.textField forPickerView:pickerTextView];
}

- (BOOL)pickerTextViewFieldShouldReturn:(PickerTextView *)pickerTextView
{
	[pickerTextView.textField resignFirstResponder];

	return YES;
}

- (void)pickerTextViewPopupSelected:(PickerTextView *)view onRow:(NSInteger)row
{
    // set the text field to the choice
    self.pickerTextNew.textField.text = [self.pickerTextNew.arrayChoices objectAtIndex:row];

    // check and see if there is more text than just the prefix
    if ([ARRAY_CATEGORY_PREFIXES indexOfObject:self.pickerTextNew.textField.text] == NSNotFound)
    {
        [view.textField resignFirstResponder];
    }
}

#pragma mark - CategoriesCell Delegates

- (void)categoriesCellDeleteTouched:(CategoriesCell *)cell
{
    NSInteger row = cell.tag;

    [self.arrayCategories removeObjectAtIndex:row];
    [self updateDisplay];
}

- (BOOL)categoriesCellTextShouldChange:(CategoriesCell *)cell charactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // create what the new value would look like
    NSString *strNewVal = [cell.pickerTextView.textField.text stringByReplacingCharactersInRange:range withString:string];

    // if it still has a prefix
    if ([self categoryPrefix:strNewVal])
    {
        // allow it
        return YES;
    }

    return NO;
}

- (void)categoriesCellTextDidChange:(CategoriesCell *)cell
{
    NSMutableString *strNewVal = [[NSMutableString alloc] init];
    [strNewVal appendString:cell.pickerTextView.textField.text];

    NSString *strPrefix = [self categoryPrefix:cell.pickerTextView.textField.text];

    // if it doesn't start with a prefix, make it
    if (strPrefix == nil)
    {
        [strNewVal insertString:[ARRAY_CATEGORY_PREFIXES objectAtIndex:0] atIndex:0];
    }

    cell.pickerTextView.textField.text = strNewVal;

    NSArray *arrayChoices = [self createNewCategoryChoices:cell.pickerTextView.textField.text];

    [cell.pickerTextView updateChoices:arrayChoices];
}

- (void)categoriesCellBeganEditing:(CategoriesCell *)cell
{
    CGPoint pos = [cell.pickerTextView.textField convertPoint:cell.pickerTextView.textField.frame.origin toView:nil];
    cell.pickerTextView.pickerMaxChoicesVisible = pos.y < POS_THRESHOLD_TO_GET_3_CHOICES ? 2 : 3;

    //[self.tableView scrollToRowAtIndexPath:[self.tableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    self.tableView.scrollEnabled = NO;
    [self forceCategoryFieldValue:cell.pickerTextView.textField forPickerView:cell.pickerTextView];
}

- (void)categoriesCellEndEditing:(CategoriesCell *)cell
{
    // change the value
    [self forceCategoryFieldValue:cell.pickerTextView.textField forPickerView:cell.pickerTextView];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSString *strNewVal = [NSString stringWithString:cell.pickerTextView.textField.text];
    [self.arrayDisplay replaceObjectAtIndex:indexPath.row withObject:strNewVal];
    [self.arrayCategories replaceObjectAtIndex:[[self.arrayDisplayPositions objectAtIndex:indexPath.row] integerValue] withObject:strNewVal];

    self.tableView.scrollEnabled = YES;

    [self updateDisplay];
}

- (BOOL)categoriesCellTextShouldReturn:(CategoriesCell *)cell
{
	[cell.pickerTextView.textField resignFirstResponder];

	return YES;
}

- (void)categoriesCellPopupSelected:(CategoriesCell *)cell onRow:(NSInteger)row
{
    // set the text field to the choice
    cell.pickerTextView.textField.text = [cell.pickerTextView.arrayChoices objectAtIndex:row];

    // check and see if there is more text than just the prefix
    if ([ARRAY_CATEGORY_PREFIXES indexOfObject:cell.pickerTextView.textField.text] == NSNotFound)
    {
        [cell.pickerTextView.textField resignFirstResponder];
    }
}

@end
