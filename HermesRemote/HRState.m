//
//  HRState.m
//  HermesRemote
//
//  Created by Sheyne Anderson on 6/16/12.
//  Copyright (c) 2012 Sheyne Anderson. All rights reserved.
//

#import "HRState.h"
#import "HRStation.h"
#import "GCDAsyncSocket.h"

void readSocket(GCDAsyncSocket *s){
    [s readDataToData:[@"\n" dataUsingEncoding:NSASCIIStringEncoding] withTimeout:-1 tag:0];
}

@interface HRState ()

@property (assign) BOOL isConnected;

@end

@implementation HRState{
    NSMutableArray *stations;
    HRStation *currentStation;
    GCDAsyncSocket *soc;
}

@synthesize isConnected;
@synthesize songName, songArtist, songAlbum;

@synthesize stations;

+(HRState *)sharedInstance{
    static HRState *state;
    if (!state){
        state = [[HRState alloc] init];
    }
    return state;
}

-(id)init{
    if (self = [super init]) {
        stations = [[NSMutableArray alloc] initWithCapacity:5];
        soc = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

-(void)connectToServer:(NSString *)server onPort:(short)port{
    if (soc.isConnected) {
        [soc disconnect];
    }
    [soc connectToHost:server onPort:port error:nil];
    [self doCommand:@"list stations"];
    readSocket(soc);
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(uint16_t)port{
    self.isConnected = YES;
}
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)error{
    self.isConnected = NO;
}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
    readSocket(sender);
    NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *r = [[response stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsSeparatedByString:@"\0"];
    NSString *command = [r objectAtIndex:0];
    
    
    if ([command isEqualToString:@"name"]) {
        [self setSongName:[r objectAtIndex:1]];
    }else if ([command isEqualToString:@"artist"]) {
        self.songArtist = [r objectAtIndex:1];
    }else if ([command isEqualToString:@"album"]) {
        self.songAlbum = [r objectAtIndex:1];
    }else if ([command isEqualToString:@"station"]) {
        HRStation *station = [HRStation stationForName:[r objectAtIndex:1]];
        station.stationId = [r objectAtIndex:2];
        [self addStation:station];
    }
}
-(void)addStation:(HRStation *)station{
    if (! [stations containsObject:station]) {
        [self willChangeValueForKey:@"stations"];
        [stations addObject:station];
        [self didChangeValueForKey:@"stations"];
    }
}
-(void)removeStation:(HRStation *)station{
    if (! [stations containsObject:station]) {
        [self willChangeValueForKey:@"stations"];
        [stations removeObject:station];
        [self didChangeValueForKey:@"stations"];
    }
}

-(HRStation*)currentStation{
    return currentStation;
}

-(void)doCommand:(NSString *)command{
    NSLog(@"sending command: \"%@\" to server", command);
    [soc writeData:[[command stringByAppendingString:@"\n"] dataUsingEncoding:NSASCIIStringEncoding] withTimeout:-1 tag:0];
}

-(void)setCurrentStation:(HRStation *)station{
    [self doCommand:[NSString stringWithFormat:@"set station\0%@", station.stationId]];
    currentStation = station;
}

@end
