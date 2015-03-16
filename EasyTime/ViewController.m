//
//  ViewController.m
//  EasyTime
//
//  Created by Saurabh Suman on 12/03/15.
//  Copyright (c) 2015 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
@interface ViewController ()
{

    NSArray *timeZone;
    NSArray *searchResults;
    NSString *selectedTimeZone;
    NSArray *collectionData;


    NSMutableArray *mutableData;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    
    
    
    timeZone =[[NSArray alloc]init];
    mutableData = [[NSMutableArray alloc]init];

     timeZone = [NSTimeZone knownTimeZoneNames];



    //self.tableView.hidden=YES;
    self.searchView.hidden=YES;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
    
   } else {
        return [timeZone count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString *CellIdentifier = @"cell";
   UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text=searchResults[indexPath.row];
    } else
    
    {
       cell.textLabel.text=timeZone[indexPath.row];
    }
    
    return cell;


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    selectedTimeZone =searchResults[indexPath.row];
    
    
    
       self.searchView.hidden =YES;
       [self.searchDisplay.searchBar resignFirstResponder];
       self.searchDisplayController.searchBar.text=[NSString stringWithFormat:@"%@",selectedTimeZone];
       self.searchDisplayController.searchResultsTableView.hidden=YES;
    
}





- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope12
{
   
    
    
    NSPredicate *rest= [NSPredicate predicateWithFormat:@"self contains[c] %@", searchText];
    
   // NSPredicate *rest = [NSPredicate predicateWithFormat:@"SELF.category contains[c] %@", searchText];
    
    searchResults = [timeZone filteredArrayUsingPredicate:rest];




}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
     self.searchDisplay.searchBar.showsCancelButton=YES;
     self.tableView.hidden=NO;
    [self filterContentForSearchText:searchString
                               scope:[[controller.searchBar scopeButtonTitles] objectAtIndex: [controller.searchBar selectedScopeButtonIndex]]];
    return YES;
}




-(void)getTimeandDateaccordingtoTimeZone
{

   
    ModelTimeClass *modelData=[[ModelTimeClass alloc]init];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [timeFormatter setDateFormat:@"HH:mm a"];

    NSLog(@"system time is %@",[timeFormatter stringFromDate:[NSDate date]]);
    
    NSLog(@"system time is %@",[dateFormatter stringFromDate:[NSDate date]]);

    
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"%@",selectedTimeZone]]];

    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"%@",selectedTimeZone]]];


    NSString *timeString = [timeFormatter stringFromDate:[NSDate date]];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    modelData.time = [timeFormatter stringFromDate:[NSDate date]];
    modelData.Date = [dateFormatter stringFromDate:[NSDate date]];
    modelData.timeZone = [NSString stringWithFormat:@"%@",selectedTimeZone];
    
    
    
    
    [mutableData addObject:modelData];
    
    
    NSLog(@"Time is.....: %@", timeString);
    NSLog(@"Date is......: %@", dateString);
    NSLog(@"system time is %@",[timeFormatter stringFromDate:[NSDate date]]);
    NSLog(@"system time is %@",[dateFormatter stringFromDate:[NSDate date]]);

}




- (IBAction)AddbuttonAction:(id)sender {

     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     selectedTimeZone = searchResults[indexPath.row];
    
    
    NSLog(@"%@",selectedTimeZone);

    [self getTimeandDateaccordingtoTimeZone];
    
    self.searchDisplayController.searchResultsTableView.hidden=YES;
    self.searchView.hidden =YES;
    
    self.searchDisplayController.searchBar.text=[NSString stringWithFormat:@""];
   // self.searchDisplayController.searchBar.showsCancelButton=NO;
    [self.searchDisplayController.searchBar resignFirstResponder];

   
    [self.collectionView reloadData];

}

- (IBAction)ImpactValueChange:(UISlider *)sender {

    sender.value = roundf(sender.value);


}



#pragma CollectionView Delegate and data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [mutableData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cellCollection";
    
    CustomCell *cell =(CustomCell *) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.deletebtn.tag = indexPath.item;
    [cell.deletebtn addTarget:self action:@selector(deleteCustom:) forControlEvents:UIControlEventTouchUpInside];
    cell.backgroundColor=[UIColor grayColor];
    UILabel *zone=(UILabel *)[cell viewWithTag:100];
    ModelTimeClass *model = mutableData[indexPath.row];
    zone.text = model.timeZone;
    UILabel *time=(UILabel *)[cell viewWithTag:101];
    time.text = model.time;
    UILabel *date=(UILabel *)[cell viewWithTag:102];
    date.text = model.Date;

 
    
    return cell;
}

-(void)deleteCustom:(UIButton *)button
{
   // NSLog(@"button tag : %d",button.tag);
    [mutableData removeObjectAtIndex:button.tag];
    
    [self.collectionView reloadData];
}












































@end
