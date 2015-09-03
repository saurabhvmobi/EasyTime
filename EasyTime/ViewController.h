//
//  ViewController.h
//  EasyTime
//
//  Created by Saurabh Suman on 12/03/15.
//  Copyright (c) 2015 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ModelTimeClass.h"
#import "PopupView.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplay;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)AddbuttonAction:(id)sender;
- (IBAction)ImpactValueChange:(UISlider*)sender;

@property (weak, nonatomic) IBOutlet UIButton *addbutton;

-(void)getTimeandDateaccordingtoTimeZone;
@property(nonatomic,strong)ModelTimeClass *modelClass;
@property(nonatomic,strong)NSString *selectedTimeZone;
@property(nonatomic,strong)NSMutableArray *mutableData;

-(NSString *)returnImageName :(NSString *)getTime;

@end

