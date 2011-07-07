//
//  P5PViewController.h
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

#import <UIKit/UIKit.h>

// declarations
@class SketchesViewController;
@class SketchViewController;
@class CollectionsViewController;
@class Collection;
@class Sketch;
@class PreloaderView;
@class NoteView;


/*
* Delegate.
*/
@protocol P5PDelegate <NSObject>
- (void)navigateToRoot;
- (void)navigateToSketch:(Sketch*)sketch;
- (void)toggleCollections;
- (void)openCollections;
- (void)closeCollections;
- (void)preloaded;
@end

/**
* P5PViewController.
*/
@interface P5PViewController : UIViewController <P5PDelegate> {

	// view controllers
	SketchesViewController *sketchesViewController;
	SketchViewController *sketchViewController;
	CollectionsViewController *collectionsViewController;
	
	// gestures
	UITapGestureRecognizer *gestureModeCollectionsTap;
	
	// modes
	BOOL modeCollections;
	
	// Preloader
	PreloaderView *preloader;
	
	// note
	NoteView *note;

}

// Properties
@property (nonatomic, retain) SketchesViewController *sketchesViewController;
@property (nonatomic, retain) SketchViewController *sketchViewController;
@property (nonatomic, retain) CollectionsViewController *collectionsViewController;
@property BOOL modeCollections;

@end
