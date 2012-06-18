//
//  HRSettingViewController.m
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/17/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import "HRSettingViewController.h"
#import "HRState.h"

@implementation HRSettingViewController

-(void)viewDidLoad{
    [[HRState sharedInstance] addObserver:self forKeyPath:@"isConnected" options:NSKeyValueObservingOptionNew context:NULL];
}

-(void)viewDidUnload{
    [[HRState sharedInstance] removeObserver:self forKeyPath:@"isConnected"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSNumber *new = [change objectForKey:@"new"];
    if (new.boolValue == YES) {
        [self performSegueWithIdentifier:@"Connect" sender:self];
    } else {
        [self.navigationController popToViewController:self animated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error" 
                                                        message:@"The server is unavailable or disconnected." 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

    }
}

-(IBAction)connect:(id)sender{
    [[HRState sharedInstance] connectToServer:address.text onPort:port.text.intValue];
    [self.view endEditing:YES];
}

@end
