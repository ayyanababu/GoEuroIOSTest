//
//  LaunchScreen.m
//  GoEuroTrial
//
//  Created by Phani on 11/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//

#import "LaunchScreen.h"

@implementation LaunchScreen
@synthesize imagesAnimation;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *animationArray = [NSArray arrayWithObjects:
                               [UIImage imageNamed:@"1.jpg"],
                               [UIImage imageNamed:@"2.jpg"],
                               [UIImage imageNamed:@"3.jpg"],
                               [UIImage imageNamed:@"4.jpeg"],
                               nil];
    self.imagesAnimation.animationImages      = animationArray;
    imagesAnimation.animationDuration    = 1.5;
    imagesAnimation.animationRepeatCount = 0;
    [imagesAnimation startAnimating];
    
}

@end
