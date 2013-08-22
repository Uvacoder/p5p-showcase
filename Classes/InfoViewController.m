//
//  InfoViewController.m
//  P5P
//
//  Created by CNPP on 17.2.2011.
//  Copyright Beat Raess 2011. All rights reserved.
//
//  This file is part of P5P.
//  
//  P5P is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//  
//  P5P is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//  
//  You should have received a copy of the GNU General Public License
//  along with P5P.  If not, see www.gnu.org/licenses/.

#import "InfoViewController.h"
#import "P5PAppDelegate.h"
#import "P5PConstants.h"
#import "CreditsViewController.h"
#import "PreferencesViewController.h"
#import	"Tracker.h"


/*
* Helper Stack.
*/
@interface InfoViewController (Helpers)
- (void)recommendEmail;
- (void)recommendTwitter;
- (void)recommendFacebook;
- (void)recommendWeibo;
- (void)recommendAppStore;
@end

/**
* Info Controller.
*/
@implementation InfoViewController


#pragma mark -
#pragma mark Properties

// accessors
@synthesize delegate;


#pragma mark -
#pragma mark View lifecycle


/*
* Loads the view.
*/
- (void)loadView {
	[super loadView];
	DLog();
	
	 // title
	self.navigationItem.title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"P5P Generative Sketches",@"P5P Generative Sketches")];
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
		self.navigationItem.title = [NSString stringWithFormat:@"%@", NSLocalizedString(@"P5P",@"P5P")];
	}
    
    // texture
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_texture.png"]];
	
	// table
	self.tableView.scrollEnabled = NO;
	self.tableView.backgroundView = nil;
    
    // done button
	UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                target:self
                                action:@selector(actionDone:)];
	self.navigationItem.rightBarButtonItem = btnDone;
	[btnDone release];
	
	// about
    float inset = iOS6 ? 30 : 15;
    float margin = 10;
	float height = 100;
    float width = 540;
	if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
		height = 150;
        width = 320;
	}

	
	// view
    UIView *about = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
	UILabel *lblAbout = [[UILabel alloc] initWithFrame:CGRectMake(inset, margin, width-2*inset, height-2*margin)];
	lblAbout.backgroundColor = [UIColor clearColor];
	lblAbout.font = [UIFont fontWithName:@"Helvetica" size:15.0];
	lblAbout.textColor = [UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1.0];
	lblAbout.shadowColor = [UIColor whiteColor];
	lblAbout.shadowOffset = CGSizeMake(0,1);
	lblAbout.opaque = YES;
	lblAbout.numberOfLines = 4;
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
		lblAbout.numberOfLines = 7;
	}
	[lblAbout setText:NSLocalizedString(@"P5P is a collection of generative sketches. The interactive visuals are each defined by a set of rules and computed by randomly modified algorithms. Adjust and tweak their parameters, touch or move the device to influence the outcome of the generated images.",@"P5P is a collection of generative sketches. The interactive visuals are each defined by a set of rules and computed by randomly modified algorithms. Adjust and tweak their parameters, touch or move the device to influence the outcome of the generated images.")];
    [about addSubview:lblAbout];
    [lblAbout release];

	// table header
	self.tableView.tableHeaderView = about;
    [about release];
	

}

/*
* Prepares the view.
*/
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	DLog();
	
	// track
	[Tracker trackPageView:[NSString stringWithFormat:@"/info"]];
}


#pragma mark -
#pragma mark Actions

/*
* Processing reset.
*/
- (void)actionDone:(id)sender {
	DLog();
	
	// dismiss
	if (delegate != nil && [delegate respondsToSelector:@selector(dismissInfo)]) {
		[delegate dismissInfo];
	}
}


#pragma mark -
#pragma mark Cell Delegates

/*
* CellButton.
*/
- (void)cellButtonTouched:(CellButton *)c {
	GLog();
	
	// reset
	switch ([c tag]) {
		
		// recommend
		case InfoActionRecommend:{
			[self actionRecommend:c];
			break;
		}
		
        // default
		default:
			break;
	}


}



#pragma mark -
#pragma mark Helpers


/*
 * Action recommend.
 */
- (void)actionRecommend:(id)sender {
    FLog();
    
    // track
    [Tracker trackEvent:TEventInfo action:@"Recommend"];
    
    // services
    BOOL email = [MailComposeController canSendMail];
    BOOL twitter = [SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter];
    BOOL facebook = [SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook];
    BOOL weibo = [SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo];
    
    // recommend
    UIActionSheet *recommendAction = [[UIActionSheet alloc] init];
    [recommendAction setDelegate:self];
    [recommendAction setTag:InfoActionRecommend];
    [recommendAction setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    [recommendAction setTitle:NSLocalizedString(@"Recommend P5P",@"Recommend P5P")];
    
    // services
    if (email) {
        [recommendAction addButtonWithTitle:NSLocalizedString(@"Email",@"Email")];
    }
    if (twitter) {
        [recommendAction addButtonWithTitle:NSLocalizedString(@"Twitter",@"Twitter")];
    }
    if (facebook) {
        [recommendAction addButtonWithTitle:NSLocalizedString(@"Facebook",@"Facebook")];
    }
    if (weibo) {
        [recommendAction addButtonWithTitle:NSLocalizedString(@"Sina Weibo",@"Sina Weibo")];
    }
    [recommendAction addButtonWithTitle:NSLocalizedString(@"App Store",@"App Store")];
    [recommendAction addButtonWithTitle:NSLocalizedString(@"Cancel",@"Cancel")];
    [recommendAction setCancelButtonIndex:recommendAction.numberOfButtons-1];
    
    // show
    [recommendAction showInView:self.navigationController.view];
    [recommendAction release];

}


/*
* Recommend Email.
*/
- (void)recommendEmail {
	DLog();
	
	// track
	[Tracker trackEvent:TEventRecommend action:@"Email"];
	
	// check mail support
	if ([MailComposeController canSendMail]) {

		// mail composer
		MailComposeController *composer = [[MailComposeController alloc] init];
		composer.mailComposeDelegate = self;
        composer.navigationBar.barStyle = UIBarStyleBlack;
        
        // ipad
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            composer.modalPresentationStyle = UIModalPresentationCurrentContext;
            composer.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        }
		
		// subject
		[composer setSubject:[NSString stringWithFormat:@"P5P iPad/iPhone App"]];
        
		// message
        NSString *message = [NSString stringWithFormat:@"%@\n%@",NSLocalizedString(@"P5P is a collection of generative sketches. The interactive visuals are each defined by a flexible set of rules and computed by randomly modified algorithms. Adjust and tweak their parameters, touch or move the device to influence the outcome of the generated images. Save, print, email or publish screenshots.\n\n\n---\nP5P\nA Collection of Generative Sketches.",@"P5P is a collection of generative sketches. The interactive visuals are each defined by a flexible set of rules and computed by randomly modified algorithms. Adjust and tweak their parameters, touch or move the device to influence the outcome of the generated images. Save, print, email or publish screenshots.\n\n\n---\nP5P\nA Collection of Generative Sketches."),vAppStoreURL];
		[composer setMessageBody:message isHTML:NO];
		
		// promo image
		UIImage *pimg = [delegate randomSketchImage];
		NSData *data = UIImagePNGRepresentation(pimg);
		[composer addAttachmentData:data mimeType:@"image/png" fileName:@"P5P"];
        
        
		// show off
        [self presentViewController:composer animated:YES completion:nil];
        
		// release
		[composer release];

	}

}

/*
* Recommend Twitter.
*/
- (void)recommendTwitter {
	DLog();
	
	// track
	[Tracker trackEvent:TEventRecommend action:@"Twitter"];
    
    // check twitter support
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        // composition view controller
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        // initial text
        [composeViewController setInitialText:NSLocalizedString(@"P5P iPad/iPhone App. A Collection of Generative Sketches. http://p5p.cecinestpasparis.net",@"P5P iPad/iPhone App. A Collection of Generative Sketches. http://p5p.cecinestpasparis.net")];
        
        // image
        UIImage *pimg = [delegate randomSketchImage];
        [composeViewController addImage:pimg];
        
        
        // completion handler
        [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            // dismiss the composition view controller
            [self dismissViewControllerAnimated:YES completion:nil];
            
            // result
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    FLog("SLCompose: cancel");
                    break;
                case SLComposeViewControllerResultDone:
                    FLog("SLCompose: done");
                    break;
                default:
                    break;
            }
            
        }];
        
        // modal
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
    
}


/*
 * Recommend Facebook.
 */
- (void)recommendFacebook {
	FLog();
    
    // track
	[Tracker trackEvent:TEventRecommend action:@"Facebook"];
	
	// check facebook support
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        // composition view controller
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        // initial text
        [composeViewController setInitialText:NSLocalizedString(@"P5P iPad/iPhone App. A Collection of Generative Sketches. http://p5p.cecinestpasparis.net",@"P5P iPad/iPhone App. A Collection of Generative Sketches. http://p5p.cecinestpasparis.net")];
        
        // image
        UIImage *pimg = [delegate randomSketchImage];
        [composeViewController addImage:pimg];
        
        // completion handler
        [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            // result
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    FLog("SLCompose: cancel");
                    break;
                case SLComposeViewControllerResultDone:
                    FLog("SLCompose: done");
                    break;
                default:
                    break;
            }
        }];
        
        // modal
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

/*
 * Recommend Weibo.
 */
- (void)recommendWeibo {
	FLog();
    
    // track
	[Tracker trackEvent:TEventRecommend action:@"Weibo"];
	
	// check twitter support
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        
        // composition view controller
        SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        
        // initial text
        [composeViewController setInitialText:NSLocalizedString(@"P5P iPad/iPhone App. A Collection of Generative Sketches. http://p5p.cecinestpasparis.net",@"P5P iPad/iPhone App. A Collection of Generative Sketches. http://p5p.cecinestpasparis.net")];
        
        // image
        UIImage *pimg = [delegate randomSketchImage];
        [composeViewController addImage:pimg];
        
        
        // completion handler
        [composeViewController setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            // dismiss the composition view controller
            [self dismissViewControllerAnimated:YES completion:nil];
            
            // result
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    FLog("SLCompose: cancel");
                    break;
                case SLComposeViewControllerResultDone:
                    FLog("SLCompose: done");
                    break;
                default:
                    break;
            }
            
        }];
        
        // modal
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}


/*
* Recommend App Store.
*/
- (void)recommendAppStore {
	DLog();
	
	// track
	[Tracker trackEvent:TEventRecommend action:@"AppStore"];
	
	// show info
	UIAlertView *alert = [[UIAlertView alloc]
						  initWithTitle:@"App Store" 
						  message:NSLocalizedString(@"Thank you for rating P5P or writing a nice review.",@"Thank you for rating P5P or writing a nice review.")
						  delegate:self 
						  cancelButtonTitle:NSLocalizedString(@"Maybe later",@"Maybe later")
						  otherButtonTitles:NSLocalizedString(@"Visit",@"Visit"),nil];
	[alert setTag:InfoAlertRecommendAppStore];
	[alert show];    
	[alert release];

}


#pragma mark -
#pragma mark UIActionSheet Delegate

/*
 * Action selected.
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	DLog();
	
	// tag
	switch ([actionSheet tag]) {
            
        // recommend
		case InfoActionRecommend: {
            
			// action
            if (buttonIndex != actionSheet.cancelButtonIndex) {
                
                // service
                NSString *service = [actionSheet buttonTitleAtIndex:buttonIndex];
                if ([service isEqualToString:@"Email"] || [service isEqualToString:@"E-Mail"] || [service isEqualToString:@"E-mail"]) {
                    [self recommendEmail];
                }
                else if ([service isEqualToString:@"Twitter"]) {
                    [self recommendTwitter];
                }
                else if ([service isEqualToString:@"Facebook"]) {
                    [self recommendFacebook];
                }
                else if ([service isEqualToString:@"Sina Weibo"]) {
                    [self recommendWeibo];
                }
                else if ([service isEqualToString:@"App Store"]) {
                    [self recommendAppStore];
                }
            }
			break;
		}
            
            
            // default
		default: {
			break;
		}
	}
	
	
}



#pragma mark -
#pragma mark UIAlertViewDelegate Delegate

/*
 * Alert view button clicked.
 */
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	FLog();
	
	// tag
	switch ([actionSheet tag]) {
	
		// recommend App Store
		case InfoAlertRecommendAppStore: {
            
			// store
			if (buttonIndex != actionSheet.cancelButtonIndex) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:vAppStoreLink]];
			}
			break;
		}
		
		// default
		default: {
			break;
		}
	}
	
}



#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Protocol

/*
 * Dismisses the email composition interface when users tap Cancel or Send.
 */
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {	
	FLog();
	
	// result
	switch (result) {
		case MFMailComposeResultCancelled:
			FLog(@"Email: canceled");
			break;
		case MFMailComposeResultSaved:
			FLog(@"Email: saved");
			break;
		case MFMailComposeResultSent:
			FLog(@"Email: sent");
			break;
		case MFMailComposeResultFailed:
			FLog(@"Email: failed");
			break;
		default:
			FLog(@"Email: not sent");
			break;
	}
	
	// close modal
    [self dismissViewControllerAnimated:YES completion:nil];

}


#pragma mark -
#pragma mark Table view data source

/*
 * Customize the number of sections in the table view.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 3;
}


/*
 * Customize the number of rows in the table view.
 */
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {

	 // section
    switch (section) {
		case SectionInfoRecommend: {
			return 1;
		}
		case SectionInfoApp: {
			return 2;
		}
    }
    
    return 0;
}



#pragma mark -
#pragma mark UITableViewDelegate Protocol


/*
 * Customize the appearance of table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// identifiers
    static NSString *CellInfoIdentifier = @"CellInfo";
	static NSString *CellInfoButtonIdentifier = @"CellPreferencesButton";
	
	// create cell
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellInfoIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellInfoIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	
	// configure
	cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0]; 
	cell.textLabel.textColor = [UIColor colorWithRed:63.0/255.0 green:63.0/255.0 blue:63.0/255.0 alpha:1.0];
	
	
	// section
    NSUInteger section = [indexPath section];
    switch (section) {
			
		// info
        case SectionInfoApp: {
		
			// preferences
            if ([indexPath row] == AppCredits) {
				
				// cell
				cell.textLabel.text = NSLocalizedString(@"Credits",@"Credits");
				
				// accessory
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			
			// preferences
            if ([indexPath row] == AppPreferences) {
				
				// cell
				cell.textLabel.text = NSLocalizedString(@"Preferences",@"Preferences");
				
				// accessory
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			}
			
			// have a break
			break; 
		}
		
		// recommend
		case SectionInfoRecommend: {
			
			// recommend
            if ([indexPath row] == RecommendApp) {
				
				// create cell
				CellButton *cbutton = (CellButton*) [tableView dequeueReusableCellWithIdentifier:CellInfoButtonIdentifier];
				if (cbutton == nil) {
					cbutton = [[[CellButton alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellInfoButtonIdentifier] autorelease];
				}				
				
				// prepare cell
				cbutton.delegate = self;
				cbutton.tag = InfoActionRecommend;
				[cbutton.buttonAccessory setTitle:NSLocalizedString(@"Recommend P5P",@"Recommend P5P") forState:UIControlStateNormal];
				[cbutton update:YES];
				
				// set cell
				cell = cbutton;

			}
			
			// break it
			break; 
		}
		

	}
	
	
	// return
    return cell;
}


/*
 * Called when a table cell is selected.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	FLog();
	
	// section
    NSUInteger section = [indexPath section];
    switch (section) {	
			
		// app
        case SectionInfoApp: {
			// credits
            if ([indexPath row] == AppCredits) {
				
				// controller
			    CreditsViewController *creditsViewController = [[CreditsViewController alloc] initWithStyle:UITableViewStyleGrouped];
				
				// navigate 
				[self.navigationController pushViewController:creditsViewController animated:YES];
				[creditsViewController release];
			}
			
			// preferences
            if ([indexPath row] == AppPreferences) {
				
				// controller
			    PreferencesViewController *preferencesViewController = [[PreferencesViewController alloc] initWithStyle:UITableViewStyleGrouped];
				
				// navigate 
				[self.navigationController pushViewController:preferencesViewController animated:YES];
				[preferencesViewController release];
			}
			break;
			
		}
	}
	
}


#pragma mark -
#pragma mark Memory management

/**
* Deallocates all used memory.
*/
- (void)dealloc {
	GLog();
	
	// duper
    [super dealloc];
}

@end

