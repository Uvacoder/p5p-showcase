//
//  MailComposeController.m
//  P5P
//
//  Created by CNPP on 21.08.13.
//
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

#import "MailComposeController.h"
#import "P5PConstants.h"

/**
 * MailComposeController.
 */
@implementation MailComposeController


#pragma mark -
#pragma mark Controller

/*
 * Init.
 */
- (id)init {
    
    // super
    if ((self = [super init])) {
        
        // tint
        if (! iOS6) {
            self.navigationBar.tintColor = [UIColor whiteColor];
        }
        
    }
    return self;
}

/*
 * Status.
 */
- (BOOL)prefersStatusBarHidden {
    return YES;
}


@end