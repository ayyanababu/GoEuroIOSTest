//
//  TableViewCell.h
//  GoEuroTrial
//
//  Created by Phani on 10/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//


/*
 custom table cell which shows the information of travel option
 
 */
#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property(strong,nonatomic) UIImageView *imageView;
@property(strong,nonatomic) UILabel *cost;
@property(strong,nonatomic) UILabel *timings;
@property(strong,nonatomic) UILabel *stops;
@property(strong,nonatomic) UILabel *journeyTime;


@end
