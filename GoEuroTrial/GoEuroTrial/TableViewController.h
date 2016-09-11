//
//  TableViewController.h
//  GoEuroTrial
//
//  Created by Phani on 11/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//


/*
 
 Basic table view controller which shows all travel options for a travel mode.
 All the basic features for all the travel modes are implemented in this class.

 */

#import <UIKit/UIKit.h>
#import <GoEuroTrial-Swift.h>
#import "Resources.h"
#import "TableViewCell.h"
#import "TravelOption.h"

@interface TableViewController : UITableViewController<UrlObserverDelegate,UIScrollViewDelegate>

@property(nonatomic) NSUInteger index;
@property(strong, nonatomic) NSMutableArray *data;
@property(strong, nonatomic) ResourceManager *resourceManager;

@end
