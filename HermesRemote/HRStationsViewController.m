//
//  HRStationsViewController.m
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/16/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import "HRStationsViewController.h"
#import "HRStation.h"
#import "HRState.h"
#import "HRStationCell.h"

@implementation HRStationsViewController{
    HRState *state;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    state = [HRState sharedInstance];
    [state addObserver:self forKeyPath:@"stations" options:NSKeyValueObservingOptionNew context:NULL];
}
-(void)viewDidUnload{
    [state removeObserver:self forKeyPath:@"stations"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [((UITableView *)self.view) reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
	return [state.stations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HRStationCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:@"StationCell"];
	HRStation *station = [state.stations objectAtIndex:indexPath.row];
	cell.station = station;
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"ShowNowPlaying"]) {
        state.currentStation = ((HRStationCell *)sender).station;
    }
}


@end
