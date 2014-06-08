//
//  TopDVDTableViewController.h
//  RottenTomatoesClient
//
//  Created by Kevin Ku on 6/8/14.
//  Copyright (c) 2014 Kevin Ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMProgressHUD/MMProgressHUD.h>

#import "RottenTomatoesInterface.h"

@interface TopDVDTableViewController : UITableViewController

@property (nonatomic, retain) NSArray *topDVDList;
@property (nonatomic) RottenTomatoesInterface *rti;

@end
