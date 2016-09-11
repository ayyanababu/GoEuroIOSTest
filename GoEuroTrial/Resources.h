//
//  Resources.h
//  GoEuroTrial
//
//  Created by Phani on 11/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceObject.h"

/*
 
 Static class to get all travel data for each model of travel.
 currently hard coaded the urls for each travel mode
 */

@interface Resources : NSObject


+(NSString *)getResourceUrl:(NSUInteger)index;
+(NSString *)getResourceName:(NSUInteger)index;

@end
