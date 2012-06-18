//
//  HRStationCell.m
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/16/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import "HRStationCell.h"

@implementation HRStationCell{
    HRStation *station;
}

-(HRStation *)station{
    return station;
}

-(void)setStation:(HRStation *)_station{
    station = _station;
	self.textLabel.text = _station.name;
}


@end
