//
//  ViewController.m
//  EasyTime
//
//  Created by Saurabh Suman on 12/03/15.
//  Copyright (c) 2015 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "PopupView.h"

@interface ViewController ()
{

    NSArray *timeZone;
    NSArray *searchResults;
   // NSString *selectedTimeZone;
    NSArray *collectionData;


   // NSMutableArray *mutableData;
    
    


  




}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
       
    
    
    
    
    self.addbutton.enabled = NO;
    
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTime:) name:@"SLIDERVALUE" object:nil];
    
    timeZone =[[NSArray alloc]init];
   
    self.mutableData = [[NSMutableArray alloc]init];

     timeZone = [NSTimeZone knownTimeZoneNames];



    //self.tableView.hidden=YES;
    self.searchView.hidden=YES;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)updateTime:(NSNotification *)notification
{
    
 
    int  value =[[notification object]integerValue];
    
    for (ModelTimeClass *modelData in self.mutableData) {
        
     [self updateCellWithValues:modelData.index sliderValue:value :modelData];
        
      
        
        
    }
    



}




-(void)updateCellWithValues:(NSInteger)index sliderValue:(int)value :(ModelTimeClass *)modelData
{
 
    //update cell value
    NSLog(@"value %ld",(long)index);
    NSInteger offsetTimeInMins = value * 15;
    NSDate *currentTime = [NSDate date];
    NSDate *modfiedDate = [currentTime dateByAddingTimeInterval:offsetTimeInMins*60];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    [timeFormatter setDateFormat:@"HH:mm a"];
    
   
    [timeFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]]];
    [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"EEEE dd MMMM" options:0 locale:[NSLocale currentLocale]]];
    
    
    
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"%@",modelData.timeZone]]];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"%@",modelData.timeZone]]];
    
    modelData.time = [timeFormatter stringFromDate:modfiedDate];
    modelData.Date = [dateFormatter stringFromDate:modfiedDate];
   
    
    NSLog(@"modelData.time %@",modelData.time);
    
    
    NSIndexPath *indexPath =[ NSIndexPath indexPathForItem:index inSection:0];
    
   [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}

#pragma TableViewDelegate

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
    
    self.addbutton.enabled=YES;
    
       self.selectedTimeZone =searchResults[indexPath.row];
    
    
    
       self.searchView.hidden =YES;
       [self.searchDisplay.searchBar resignFirstResponder];
       self.searchDisplayController.searchBar.text=[NSString stringWithFormat:@"%@",self.selectedTimeZone];
       self.searchDisplayController.searchResultsTableView.hidden=YES;
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope12
{
   
NSPredicate *rest= [NSPredicate predicateWithFormat:@"self contains[c] %@", searchText];
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
//    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
//    [timeFormatter setDateFormat:@"HH:mm a"];
    
     [timeFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"hh:mm a" options:0 locale:[NSLocale currentLocale]]];
     [dateFormatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"EEEE dd MMMM" options:0 locale:[NSLocale currentLocale]]];
    
    NSLog(@"system time is %@",[timeFormatter stringFromDate:[NSDate date]]);
    NSLog(@"system time is %@",[dateFormatter stringFromDate:[NSDate date]]);
   [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"%@",self.selectedTimeZone]]];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:[NSString stringWithFormat:@"%@",self.selectedTimeZone]]];
    NSString *timeString = [timeFormatter stringFromDate:[NSDate date]];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    modelData.time = [timeFormatter stringFromDate:[NSDate date]];
    modelData.Date = [dateFormatter stringFromDate:[NSDate date]];
    modelData.timeZone = self.selectedTimeZone;
    [self.mutableData addObject:modelData];
    
    
    NSLog(@"Time is.....: %@", timeString);
    NSLog(@"Date is......: %@", dateString);
    NSLog(@"system time is %@",[timeFormatter stringFromDate:[NSDate date]]);
    NSLog(@"system time is %@",[dateFormatter stringFromDate:[NSDate date]]);

}




- (IBAction)AddbuttonAction:(id)sender {

     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    self. selectedTimeZone = searchResults[indexPath.row];
    
    
    NSLog(@"%@",self.selectedTimeZone);

    [self getTimeandDateaccordingtoTimeZone];
    
    
    self.searchDisplayController.searchResultsTableView.hidden=YES;
    self.searchView.hidden =YES;
    
    self.searchDisplayController.searchBar.text=[NSString stringWithFormat:@""];
    self.addbutton.enabled = NO;
    
    
    // self.searchDisplayController.searchBar.showsCancelButton=NO;
    [self.searchDisplayController.searchBar resignFirstResponder];

   
    [self.collectionView reloadData];

}

- (IBAction)ImpactValueChange:(UISlider *)sender {

    sender.value = roundf(sender.value);


}



#pragma CollectionView Delegate and data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.mutableData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cellCollection";
    
    CustomCell *cell =(CustomCell *) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.deletebtn.tag = indexPath.item;
    [cell.deletebtn addTarget:self action:@selector(deleteCustom:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.backgroundColor=[UIColor grayColor];
    UILabel *zone=(UILabel *)[cell viewWithTag:100];
    ModelTimeClass *model = self.mutableData[indexPath.row];
    model.index = indexPath.row;
    
   
    
    NSString *str = [NSString stringWithFormat:@"%@",model.timeZone];
    
    NSArray *arr = [str componentsSeparatedByString:@"/"];
    if (arr)
    {
        NSString * firstString = [arr objectAtIndex:0];
        NSString * secondString = [arr objectAtIndex:1];
        NSLog(@"First String %@",firstString);
        NSLog(@"Second String %@",secondString);
    }
    
    
    zone.text =  [arr objectAtIndex:1];//model.timeZone;
    
    
    UILabel *time=(UILabel *)[cell viewWithTag:101];
    time.text = model.time;
    UILabel *date=(UILabel *)[cell viewWithTag:102];
    date.text = model.Date;

    UIImageView *img=(UIImageView *)[cell viewWithTag:500];
   // img.image=[UIImage imageNamed:@"cellbackground3"];
    
   
    
    img.image=[UIImage imageNamed:[self returnImageName:model.time]];
    
    
    
    return cell;
}

-(void)deleteCustom:(UIButton *)button
{
   // NSLog(@"button tag : %d",button.tag);
    [self.mutableData removeObjectAtIndex:button.tag];
    [self.collectionView reloadData];
}



-(NSString *)returnImageName :(NSString *)getTime
{

    NSString *imageName;

    
    NSLog(@"%@",getTime);
    
    int time;
    time = [getTime integerValue];
    
    
if ((time >=0) &&(time<3)) {
        imageName =@"cellbackground1";
    }
   
    else if((time >=3)&&(time<6))
    {
    imageName =@"cellbackground2";
    }
    
    else if((time >=6)&&(time<9))
    {
     imageName =@"cellbackground3";
    }
    
    else if((time >=9)&&(time<=12))
    {
     imageName =@"cellbackground4";
    }
    



   
    
    
    return imageName;

}











































@end
