//
//  SliderCustomClass.h
//  EasyTime
//
//  Created by Saurabh Suman on 16/03/15.
//  Copyright (c) 2015 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PopupView.h"

@interface SliderCustomClass : UISlider
@property (strong, nonatomic) PopupView *popupView;

@property (nonatomic, readonly) CGRect thumbRect;

@end
