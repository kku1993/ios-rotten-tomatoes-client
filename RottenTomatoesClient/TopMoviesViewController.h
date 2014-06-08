//
//  TopMoviesViewController.h
//  RottenTomatoesClient
//
//  Created by Kevin Ku on 6/5/14.
//  Copyright (c) 2014 Kevin Ku. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMProgressHUD/MMProgressHUD.h>

#import "RottenTomatoesInterface.h"

@interface TopMoviesViewController : UITableViewController

@property (nonatomic, retain) NSArray *boxOfficeList;
@property (nonatomic) RottenTomatoesInterface *rti;

@end
