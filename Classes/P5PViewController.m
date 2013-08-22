//
//  P5PViewController.m
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

#import "P5PViewController.h"
#import "P5PAppDelegate.h"
#import "P5PConstants.h"
#import "SketchesViewController.h"
#import "SketchViewController.h"
#import "PreloaderView.h"
#import "NoteView.h"



/**
* P5PViewController.
*/
@implementation P5PViewController



#pragma mark -
#pragma mark Properties

// accessors
@synthesize sketchesViewController;
@synthesize sketchViewController;


#pragma mark -
#pragma mark Object Methods

/**
* Init.
*/
- (id)init {
	
	// init super
	if (self = [super init]) {
		GLog();
		
		// return
		return self;
	}
	
	// nil not nile
	return nil;
}


#pragma mark -
#pragma mark View lifecycle

/*
* Loads the view.
*/
-(void)loadView {
	[super loadView];
	FLog();

	// blanc view
	self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	self.view.backgroundColor = [UIColor blackColor];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	
	// prepare controlers
	sketchesViewController.delegate = self;
	sketchViewController.delegate = self;

	
	// prepare views
	CGRect sframe = self.view.bounds;
	sketchesViewController.view.frame = CGRectMake(sframe.origin.x, sframe.origin.y, sframe.size.width, sframe.size.height);
	sketchesViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	
	sketchViewController.view.frame = CGRectMake(sframe.origin.x, sframe.origin.y, sframe.size.width, sframe.size.height);
	sketchViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	sketchViewController.view.hidden = YES;
	
 
	// add view
	[self.view addSubview:sketchViewController.view];
	[self.view sendSubviewToBack:sketchViewController.view];
	
	// show default view controller
	[self.view addSubview:sketchesViewController.view];
	[self.view bringSubviewToFront:sketchesViewController.view];
	[sketchesViewController viewWillAppear:NO];
	
	// note
	NoteView *nv = [[NoteView alloc] initWithFrame:self.view.frame];
	[nv setAutoresizingMask: (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight) ];
	
	// set and add to view 
	note = [nv retain];
	[self.view addSubview:note];
    [self.view bringSubviewToFront:note];
	[nv release];
	
	// preloader
	PreloaderView *pl = [[PreloaderView alloc] initWithFrame:self.view.frame];
	preloader = [pl retain];
	[self.view addSubview:preloader];
	[self.view bringSubviewToFront:preloader];
	[pl release];
	
	// preload page
	[sketchViewController loadSketch];
}

/*
 * Prepares the view.
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	FLog();
    
    // show sketch notification
    NSString *appNotification = (NSString*) [(P5PAppDelegate*)[[UIApplication sharedApplication] delegate] retrieveNotification:udNoteApp];
    if (appNotification) {
        [note notificationInfo:appNotification];
        [note showNotificationAfterDelay:3];
    }
    
}



#pragma mark -
#pragma mark Controller

/*
* Rotation.
*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

/*
 * Status.
 */
- (BOOL)prefersStatusBarHidden {
    return YES;
}



#pragma mark -
#pragma mark P5PDelegate

/**
* Shows the sketch view.
*/
- (void)navigateToSketch:(Sketch*)sketch {
	DLog();
	
	// prepare controllers
	sketchViewController.sketch = sketch;
	[sketchViewController viewWillAppear:YES];
	[sketchesViewController viewWillDisappear:YES];
 
	// prepare view
    [sketchesViewController.view setTransform:CGAffineTransformMakeScale(1.0,1.0)];
    [sketchViewController.view setCenter:CGPointMake(self.view.frame.size.width * 1.5, self.view.frame.size.height / 2.0)];
    [sketchViewController.view setHidden:NO];
    [self.view bringSubviewToFront:sketchViewController.view];
 
	// animate
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        
                         // animate
                         [sketchesViewController.view setTransform:CGAffineTransformMakeScale(0.98,0.98)];
                         [sketchViewController.view setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
        
                     }
                     completion:^(BOOL finished) {
    
                         // sketches view
                         [sketchesViewController viewDidDisappear:YES];
                         [sketchesViewController.view setHidden:YES];
	
                         // sketch view
                         [sketchViewController viewDidAppear:YES];
                         [self.view bringSubviewToFront:sketchViewController.view];
    
                     }
     ];
    
}



/**
* Shows the sketches view.
*/
- (void)navigateToRoot {
	DLog();
	
	// prepare controllers
	[sketchesViewController viewWillAppear:YES];
	[sketchViewController viewWillDisappear:YES];
 
	// prepare view
    [sketchesViewController.view setTransform:CGAffineTransformMakeScale(0.98,0.98)];
    [sketchesViewController.view setHidden:NO];
    [sketchViewController.view setCenter:CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0)];
 
	// animate
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         // animate
                         [sketchesViewController.view setTransform:CGAffineTransformMakeScale(1.0,1.0)];
                         [sketchViewController.view setCenter:CGPointMake(self.view.frame.size.width * 1.5, self.view.frame.size.height / 2.0)];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         // sketch view
                         [sketchViewController viewDidDisappear:YES];
                         [sketchViewController.view setHidden:YES];
                         [self.view sendSubviewToBack:sketchViewController.view];
                         
                         // sketches view
                         [sketchesViewController viewDidAppear:YES];
                         [self.view bringSubviewToFront:sketchesViewController.view];
                         
                     }
     ];
}

/**
* Shows the sketches view.
*/
- (void)preloaded {
	NSLog(@"P5P sketches preloaded.");
	
	// dismiss preloader
	[preloader dismissPreloader];
}

/**
 * Returns the controller.
 */
- (UIViewController*)controller {
    return self;
}


#pragma mark -
#pragma mark Memory management

/*
 * Deallocates used memory.
 */
- (void)dealloc {
	GLog();
	
	// remove
	[sketchesViewController viewWillDisappear:NO];
	[sketchesViewController.view removeFromSuperview];
	[sketchesViewController viewDidDisappear:NO];
	
	[sketchViewController viewWillDisappear:NO];
	[sketchViewController.view removeFromSuperview];
	[sketchViewController viewDidDisappear:NO];
	
	// release resources
    [sketchesViewController release];
	[sketchViewController release];
	
	// release global
    [super dealloc];
}


@end