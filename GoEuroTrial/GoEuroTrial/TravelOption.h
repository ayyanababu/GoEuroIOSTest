//
//  TravelOption.h
//  GoEuroTrial
//
//  Created by Phani on 11/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 Basic modal class which gives the travel information reuired for user.
 In future it can be extended for each travel mode to give more specfic information based on travel modes.
 
 */

@interface TravelOption : NSObject

@property(strong,nonatomic) NSString *imageUrl;
@property(strong,nonatomic) NSString *cost;
@property(strong,nonatomic) NSString *startTime;
@property(strong,nonatomic) NSString *endTime;
@property(strong,nonatomic) NSString *noOfStops;
@property(strong,nonatomic) NSString *journeyTime;

@end
