//
//  BeaconInfoTableViewCell.m
//  iBeacons Demo
//
//  Created by Adam Lowther on 5/28/14.
//  Copyright (c) 2014 Mobient. All rights reserved.
//

#import "BeaconInfoTableViewCell.h"

@implementation BeaconInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
