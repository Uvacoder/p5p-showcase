//
//  CellButton.m
//  P5P
//
//  Created by CNPP on 4.3.2011.
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

#import "CellButton.h"
#import "P5PConstants.h"

/*
* Helper Stack.
*/
@interface CellButton (Helpers)
- (void)buttonTouchUpInside:(UIButton*)b;
@end


/**
 * CellButton.
 */
@implementation CellButton

#pragma mark -
#pragma mark Properties

// accessors
@synthesize delegate;
@synthesize buttonAccessory;


#pragma mark -
#pragma mark TableCell Methods

/*
 * Init cell.
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)identifier {
	GLog();
	
	// init cell
    self = [super initWithStyle:style reuseIdentifier:identifier];
    if (self == nil) { 
        return nil;
    }
	
    // self
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    self.autoresizesSubviews = YES;
    self.accessoryView = nil;
    self.backgroundColor = [UIColor clearColor];
    
    // remove background view
    self.backgroundView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
    
    // content view
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.contentView.autoresizesSubviews = YES;
    self.contentView.backgroundColor = [UIColor clearColor];
	
	
	// button
    UIButton *buttonObj = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonObj.backgroundColor = [UIColor whiteColor];
    buttonObj.frame = CGRectZero;
    [buttonObj.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:16.0]];
    [buttonObj setTitleEdgeInsets: iOS6 ? UIEdgeInsetsMake(-2, 5, 0, 5) : UIEdgeInsetsMake(0, 5, 0, 5)];
    [buttonObj setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
    [buttonObj setTitleColor:[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1] forState:UIControlStateHighlighted];
    [buttonObj setTitle:@"Button" forState:UIControlStateNormal];
    if (iOS6) {
        buttonObj.layer.cornerRadius = 6;
        buttonObj.layer.borderWidth = 1;
        buttonObj.layer.borderColor = [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1.0].CGColor;
    }
				
	// targets and actions
	[buttonObj addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
				
	// add
    self.buttonAccessory = buttonObj;
    [self.contentView addSubview:buttonAccessory];
    [self bringSubviewToFront:buttonAccessory];

    // return
    return self;
}

/*
 * Layout.
 */
- (void)layoutSubviews {
    GLog();
    
    // button
    CGRect fButton = CGRectInset(self.contentView.frame, iOS6 ? (iPad ? 30 : 10) : 0, 0);
    fButton.size.height = iOS6 ? 40 : 45;
    self.buttonAccessory.frame = fButton;
    
}


/*
 * Disable highlighting of currently selected cell.
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:NO];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}


#pragma mark -
#pragma mark Business

/**
* Updates the cell.
*/
- (void)update:(BOOL)reset {
	GLog();

}


#pragma mark -
#pragma mark Helpers

/*
* Switch value changed.
*/
- (void)buttonTouchUpInside:(UIButton*)b {
	GLog();
	
	// delegate
	if (delegate != nil && [delegate respondsToSelector:@selector(cellButtonTouched:)]) {
		[delegate cellButtonTouched:self];
	}
}


#pragma mark -
#pragma mark Memory management

/*
 * Deallocates all used memory.
 */
- (void)dealloc {
	GLog();
	//[buttonAccessory release];
    [super dealloc];
}

@end
