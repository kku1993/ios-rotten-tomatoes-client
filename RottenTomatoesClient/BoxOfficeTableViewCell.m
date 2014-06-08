//
//  BoxOfficeTableViewCell.m
//  RottenTomatoesClient
//
//  Created by Kevin Ku on 6/7/14.
//  Copyright (c) 2014 Kevin Ku. All rights reserved.
//

#import "BoxOfficeTableViewCell.h"

@implementation BoxOfficeTableViewCell

@synthesize titleLabel;
@synthesize descriptionLabel;
@synthesize posterView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
