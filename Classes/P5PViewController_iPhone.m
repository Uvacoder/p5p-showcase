//
//  P5PViewController_iPhone.m
//  P5P
//
//  Created by CNPP on 10.2.2011.
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

#import "P5PViewController_iPhone.h"
#import "SketchesViewController_iPhone.h"
#import "SketchViewController_iPhone.h"


/**
* P5PViewController iPhone.
*/
@implementation P5PViewController_iPhone


#pragma mark -
#pragma mark Object Methods

/**
* Init.
*/
- (id)init {
	
	// init super
	if (self = [super init]) {
		FLog();
        
        // init sketches
        SketchesViewController_iPhone *sktsvc = [[SketchesViewController_iPhone alloc] init];
		self.sketchesViewController = sktsvc;
        [sktsvc release];
		
		// init sketch
        SketchViewController_iPhone *skvc = [[SketchViewController_iPhone alloc] init];
		self.sketchViewController = skvc;
        [skvc release];
		
		// return of the jedi
		return self;
	}
	
	// oh oh
	return nil;
}

@end
