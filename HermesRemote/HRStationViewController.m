//
//  HRStationViewController.m
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/16/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import "HRStationViewController.h"
#import "HRState.h"

@implementation HRStationViewController


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    ((UILabel *)[self valueForKeyPath:keyPath]).text = [change valueForKey:@"new"];
}

-(IBAction)playpause:(id)sender{
    [[HRState sharedInstance] doCommand:@"playpause"];
}
-(IBAction)skip:(id)sender{
    [[HRState sharedInstance] doCommand:@"skip"];
}
-(IBAction)thumbsdown:(id)sender{
    [[HRState sharedInstance] doCommand:@"thumbs down"];
}
-(IBAction)thumbsup:(id)sender{
    [[HRState sharedInstance] doCommand:@"thumbs up"];
}

-(void)viewDidAppear:(BOOL)animated{
    [[HRState sharedInstance] addObserver:self forKeyPath:@"songName" options:NSKeyValueObservingOptionNew context:NULL];
    [[HRState sharedInstance] addObserver:self forKeyPath:@"songArtist" options:NSKeyValueObservingOptionNew context:NULL];
    [[HRState sharedInstance] addObserver:self forKeyPath:@"songAlbum" options:NSKeyValueObservingOptionNew context:NULL];
    [[HRState sharedInstance] doCommand:@"list playing"];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[HRState sharedInstance] removeObserver:self forKeyPath:@"songName"];  
    [[HRState sharedInstance] removeObserver:self forKeyPath:@"songArtist"];  
    [[HRState sharedInstance] removeObserver:self forKeyPath:@"songAlbum"];  
}
@end
