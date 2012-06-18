//
//  HRStationViewController.h
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/16/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRStationViewController : UIViewController{
    IBOutlet UILabel *songName, *songArtist, *songAlbum;
}

-(IBAction)playpause:(id)sender;
-(IBAction)skip:(id)sender;
-(IBAction)thumbsdown:(id)sender;
-(IBAction)thumbsup:(id)sender;


@end
