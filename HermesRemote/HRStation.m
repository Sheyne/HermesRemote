//
//  HRStation.m
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/16/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import "HRStation.h"

@implementation HRStation

@synthesize name;
@synthesize stationId;

static NSMutableDictionary *station_dict = nil;

+(HRStation *)stationForName:(NSString *)name{
    if (!station_dict){
        station_dict = [[NSMutableDictionary alloc] init];
    }
    HRStation *instance;
    if (!(instance = [station_dict objectForKey:name])){
        instance = [[HRStation alloc] initWithName: name];
        [station_dict setObject:instance forKey:name];
    }
    return instance;
}

-(id)initWithName:(NSString *)_name{
    if (self = [super init]) {
        name = _name;
    }
    return self;
}


@end
