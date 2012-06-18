//
//  HRStation.h
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/16/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRStation : NSObject

@property  NSString *stationId;
@property (weak, readonly) NSString *name;

+(HRStation *)stationForName:(NSString *)name;
-(id)initWithName:(NSString *)name;

@end
