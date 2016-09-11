//
//  Resources.m
//  GoEuroTrial
//
//  Created by Phani on 11/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//

#import "Resources.h"

@implementation Resources

+(NSArray *)resources
{
    static NSArray *_resources;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        ResourceObject *flight = [[ResourceObject alloc] init];
        flight.name = @"Flights";
        flight.url = @"https://api.myjson.com/bins/w60i";
        
        ResourceObject *trains = [[ResourceObject alloc] init];
        trains.name = @"Trains";
        trains.url = @"https://api.myjson.com/bins/3zmcy";
        
        ResourceObject *buses = [[ResourceObject alloc] init];
        buses.name = @"Buses";
        buses.url = @"https://api.myjson.com/bins/37yzm";
        
        
        _resources = @[flight,trains,buses];
    });
    return _resources;
}

+(NSString *)getResourceUrl:(NSUInteger)index
{
    return [[[Resources resources]objectAtIndex:index] url];
}

+(NSString *)getResourceName:(NSUInteger)index
{
    return [[[Resources resources]objectAtIndex:index] name];
}

@end
