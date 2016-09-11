//
//  TableViewController.m
//  GoEuroTrial
//
//  Created by Phani on 11/09/16.
//  Copyright © 2016 Phani. All rights reserved.
//

#import "TableViewController.h"

@implementation TableViewController
@synthesize index,resourceManager;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.data = [[NSMutableArray alloc] init];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.URLCache = [NSURLCache sharedURLCache];
    configuration.requestCachePolicy = NSURLRequestReturnCacheDataElseLoad;
    self.resourceManager = [[ResourceManager alloc] initWithConfiguration:configuration];
  
    [self.resourceManager getDataFor:[Resources getResourceUrl:index] withIdentifier:[Resources getResourceName:index] withUrlObserver:self];
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:(231.0/255.0) green:(69.0/255.0) blue:(32.0/255.0) alpha:1.0]];
    
    self.tableView.allowsSelection = false;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    TravelOption *option = [self.data objectAtIndex:indexPath.row];
    cell.cost.text = [NSString stringWithFormat:@"€%0.2f", [option.cost floatValue]];
    cell.timings.text = [NSString stringWithFormat:@"%@  →  %@", option.startTime,option.endTime];
    
    NSString *stopsValue = @"Direct";
    
    if(option.noOfStops.integerValue > 1 )
    {
        stopsValue = [NSString stringWithFormat:@"%@ Stops",option.noOfStops];
        
    }else if(option.noOfStops.integerValue > 0 ){
        
        stopsValue = [NSString stringWithFormat:@"%@ Stop",option.noOfStops];
        
    }
    
    cell.stops.text = stopsValue;
    
    cell.journeyTime.text = option.journeyTime;

    
    //self.resourceManager.getDataFor(url, withIdentifier: "CellIdentifier",withUrlObserver: self);
    
    
    if (!tableView.dragging && !tableView.decelerating) {
        
        [self.resourceManager getDataFor:option.imageUrl withIdentifier:@"ResourceIdentifier" withUrlObserver:self];
    }
    
    if(cell.accessoryView == nil)
    {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.accessoryView = indicator;
    }
    
    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)cell.accessoryView;
    
    [indicator startAnimating];
    
    cell.imageView.image = [UIImage imageNamed:@"Placeholder"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

-(void)didFetchUrlData:(NSString *)urlString data:(NSData *)data errorMessage:(NSString *)errorMessage
{
    
    if([urlString containsString:@"api.myjson.com"])
    {
        [self reloadDataWithTravelOptions:data];
        
    }else{
        
        UIImage *Image = [UIImage imageWithData:data];
        
        for(int i=0;i<self.data.count;i++)
        {
            TravelOption *option = [self.data objectAtIndex:i];
            
            if([urlString isEqualToString:option.imageUrl])
            {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                TableViewCell *cell = (TableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.imageView.image = Image;
                    UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)cell.accessoryView;
                    
                    [indicator stopAnimating];
                    cell.accessoryView = nil;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                });
            }
        }
    }
    
}


-(void)reloadDataWithTravelOptions:(NSData *)data
{
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:data
                                                         options:0
                                                           error:nil];
    
    for(int i=0;i<dataArray.count;i++)
    {
        NSDictionary *dict = [dataArray objectAtIndex:i];
        TravelOption *opt = [[TravelOption alloc] init];
        
        NSString *url = [[dict objectForKey:@"provider_logo"] stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
        
        opt.imageUrl = url;
        opt.cost = [dict objectForKey:@"price_in_euros"];
        opt.startTime = [dict objectForKey:@"departure_time"];
        opt.endTime = [dict objectForKey:@"arrival_time"];
        opt.noOfStops = [dict objectForKey:@"number_of_stops"];
        opt.journeyTime = [NSString stringWithFormat:@"%0.2f H", ([opt.endTime floatValue] - [opt.startTime floatValue])];
        
        [self.data addObject:opt];
    }
    
    [self.tableView reloadData];
}

#pragma mark - scrollview delgate

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    
//    for(int i=0 ;i < self.data.count;i++)
//    {
//       TravelOption *option = [self.data objectAtIndex:i];
//        [self.resourceManager cancelDataFor:option.imageUrl withIdentifier:@"ResourceIdentifier"];
//    }
//    
//}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;{
    if(!decelerate){
        [self loadImagesForOnscreenCells];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self loadImagesForOnscreenCells];
    
}

-(void) loadImagesForOnscreenCells{
    
    NSArray *pathsArray = self.tableView.indexPathsForVisibleRows;
    
    for(int i=0 ;i < pathsArray.count;i++)
    {
        NSIndexPath *path  = [pathsArray objectAtIndex:i];
        TravelOption *option = [self.data objectAtIndex:path.row];
        [self.resourceManager getDataFor:option.imageUrl withIdentifier:@"ResourceIdentifier" withUrlObserver:self];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
