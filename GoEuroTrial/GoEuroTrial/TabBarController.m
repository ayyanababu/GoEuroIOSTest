//
//  TabBarController.m
//  GoEuroTrial
//
//  Created by Phani on 11/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//

#import "TabBarController.h"

@implementation TabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(0, 0, 200, 44);
    
    CGRect labelRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height*0.6);
    CGRect dateRect = CGRectMake(rect.origin.x, rect.origin.y+rect.size.height*0.6, rect.size.width, rect.size.height*0.4);
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    //label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"Berlin - Munich";
    
    UILabel *date = [[UILabel alloc] initWithFrame:dateRect];
    date.backgroundColor = [UIColor clearColor];
    date.font = [UIFont boldSystemFontOfSize:12.0];
    //date.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    date.textAlignment = NSTextAlignmentCenter;
    date.textColor = [UIColor whiteColor];
    date.text = @"Jul 07";
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view addSubview:label];
    [view addSubview:date];
    
    self.navigationItem.titleView = view;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    self.tabBar.translucent= NO;
    
}

@end
