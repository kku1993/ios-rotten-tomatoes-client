//
//  BoxOfficeTableViewCell.h
//  RottenTomatoesClient
//
//  Created by Kevin Ku on 6/7/14.
//  Copyright (c) 2014 Kevin Ku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoxOfficeTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UIImageView *posterView;
@end
