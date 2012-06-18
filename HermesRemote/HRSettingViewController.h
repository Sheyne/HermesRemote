//
//  HRSettingViewController.h
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/17/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRSettingViewController : UIViewController{
    IBOutlet UITextField *address;
    IBOutlet UITextField *port;
}
-(IBAction)connect:(id)sender;
@end
