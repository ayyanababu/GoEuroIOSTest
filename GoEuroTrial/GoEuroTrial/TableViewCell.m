//
//  TableViewCell.m
//  GoEuroTrial
//
//  Created by Phani on 10/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize imageView,cost,timings,stops,journeyTime;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        [self prepareContent];
    }
    
    return self;
    
}

-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    
    [self prepareContent];
    return self;
}

-(void)prepareContent{
    
    imageView = [[UIImageView alloc]init];
    cost = [self getLabel];
    cost.font = [UIFont boldSystemFontOfSize:15.0];
    cost.textAlignment =  NSTextAlignmentRight;
    
    timings = [self getLabel];
    timings.textColor = [UIColor lightGrayColor];
    stops = [self getLabel];
    stops.textColor = [UIColor lightGrayColor];
    stops.textAlignment =  NSTextAlignmentRight;
    
    journeyTime = [self getLabel];
    journeyTime.textColor = [UIColor lightGrayColor];
    journeyTime.textAlignment =  NSTextAlignmentRight;
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:cost];
    [self.contentView addSubview:timings];
    [self.contentView addSubview:stops];
    [self.contentView addSubview:journeyTime];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect contentRect = self.contentView.frame;
    CGFloat originX = contentRect.origin.x+20;
    CGFloat width = contentRect.size.width;
    
    CGRect frame;
    frame = CGRectMake(originX ,10, width*0.4, 40);
    imageView.frame = frame;
    
    frame = CGRectMake(width-100 ,10, 90, 40);
    cost.frame = frame;
    
     CGFloat originY = contentRect.origin.y+imageView.frame.size.height+15;
    
    frame = CGRectMake(originX+5 ,originY, 100, 30);
    timings.frame = frame;
    
    frame= CGRectMake(width-150 ,originY, 75, 30);
    stops.frame = frame;
    
    frame= CGRectMake(width-70 ,originY, 60, 30);
    journeyTime.frame = frame;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)getLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14];
    
    return label;
}

@end
