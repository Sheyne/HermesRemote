//
//  HRState.h
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/16/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRStation.h"

@interface HRState : NSObject

@property  (retain) NSString *songName, *songArtist, *songAlbum;

@property (readonly) BOOL isConnected;
@property (readonly) NSArray *stations;
@property (weak) HRStation *currentStation;
-(void)doCommand:(NSString *) command;

+(HRState *)sharedInstance;

-(void)connectToServer:(NSString *)server onPort:(short)port;
-(void)addStation:(HRStation *)station;
-(void)removeStation:(HRStation *)station;

@end
