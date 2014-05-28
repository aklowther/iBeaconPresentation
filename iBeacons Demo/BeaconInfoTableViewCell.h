//
//  BeaconInfoTableViewCell.h
//  iBeacons Demo
//
//  Created by Adam Lowther on 5/28/14.
//  Copyright (c) 2014 Mobient. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *proximity;
@property (weak, nonatomic) IBOutlet UILabel *major;
@property (weak, nonatomic) IBOutlet UILabel *minor;
@property (weak, nonatomic) IBOutlet UILabel *accuracy;
@property (weak, nonatomic) IBOutlet UILabel *distance;

@end
