//
//  P5PConstants.m
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


// User Default Keys
#define udInformationAppVersion					@"information_app_version"	
#define udPreferenceSoundDisabled				@"preference_sound_disabled"
#define udPreferenceToolbarAutohideEnabled		@"preference_toolbar_autohide_enabled"	
#define udPreferenceRefreshTapEnabled           @"preference_refresh_tap_enabled"		
#define udPreferenceEmail						@"preference_email"	
#define udSketchSettings						@"sketch_settings"	
#define udNoteApp                               @"note_app"	

// Values
#define vAppEmail                               @"p5p@cecinestpasparis.net"	
#define vAppWebsite                             @"http://p5p.cecinestpasparis.net"	
#define vAppStoreURL                            @"http://itunes.apple.com/app/p5p-generative-sketches/id443413228?mt=8"
#define vAppStoreLink                           @"itms-apps://itunes.apple.com/app/id443413228"

// Flags
#define iPad                                    (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define iPhone                                  (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
#define iOS6                                    ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending)