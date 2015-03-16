//
//  PopupView.m
//  EasyTime
//
//  Created by Saurabh Suman on 16/03/15.
//  Copyright (c) 2015 Vmoksha Technologies Pvt Ltd. All rights reserved.
//

#import "PopupView.h"
 @implementation PopupView

{
    UILabel *textLabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont boldSystemFontOfSize:15.0f];
        
        UIImageView *popoverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sliderlabel.png"]];
        [self addSubview:popoverView];
        
        textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.font = self.font;
        textLabel.textColor = [UIColor colorWithWhite:1.0f alpha:0.7];
        textLabel.text = self.text;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.frame = CGRectMake(0, -2.0f, popoverView.frame.size.width, popoverView.frame.size.height);
        [self addSubview:textLabel];
        
    }
    return self;
}
-(void)setValue:(float)aValue {
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
       [timeFormatter setDateFormat:@"HH:mm a"];
    
    NSString *systemTime;
    
    systemTime = [timeFormatter stringFromDate:[NSDate date ]];
    _value = aValue;
    self.text = [NSString stringWithFormat:@"%@",systemTime];
    textLabel.text = self.text;
    [self setNeedsDisplay];





}



@end
