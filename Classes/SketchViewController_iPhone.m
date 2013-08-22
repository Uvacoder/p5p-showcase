//
//  SketchViewController_iPhone.m
//  P5P
//
//  Created by CNPP on 27.1.2011.
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

#import "SketchViewController_iPhone.h"


/**
* SketchViewController_iPhone.
*/
@implementation SketchViewController_iPhone


#pragma mark -
#pragma mark Actions

/*
* Settings.
*/
- (void)actionSettings:(id)sender {
	DLog();
 
	// navigation controller
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
	navController.navigationBar.barStyle = UIBarStyleBlack;
    navController.navigationBar.translucent = NO;
	navController.toolbar.barStyle = UIBarStyleBlack;
    navController.toolbar.translucent = NO;
	navController.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_texture.png"]];
	[navController setToolbarHidden:NO animated:NO];

	// show
	[navController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    [self presentViewController:navController animated:YES completion:nil];
	[navController release];	
	
	// everything super
	[super actionSettings:sender];
}



#pragma mark -
#pragma mark SettingDelegate

/*
 * Settings apply.
 */
- (void)settingsApply {
	FLog();
	
	// pop it goes
    [self dismissViewControllerAnimated:YES completion:nil];
	
	// refresh super
	[super settingsApply];
	
}


@end
