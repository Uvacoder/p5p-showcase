//
//  Utils.m
//  P5P
//
//  Created by Beat Raess on 6.4.2012.
//  Copyright (c) 2012 Beat Raess. All rights reserved.
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

#import "Utils.h"


/**
 * Utils.
 */
@implementation Utils


/**
 * Detect retina display.
 */
+ (BOOL)isRetina {
    
    // scale
    static CGFloat scale = 0.0;
    if (scale == 0.0) {
        
        // check
        if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0)) {
            scale = 2.0;
            return YES;
        } else {
            scale = 1.0;
            return NO;
        }   
        
    }
    return scale > 1.0;
}

/**
 * Detect 4inch display.
 */
+ (BOOL)is4inch {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        CGRect screen = [[UIScreen mainScreen] bounds];
        if (screen.size.height == 568) {
            return YES;
        }
    }
    return NO;
}

@end
