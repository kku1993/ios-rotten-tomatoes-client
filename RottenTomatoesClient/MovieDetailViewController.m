//
//  MovieDetailViewController.m
//  RottenTomatoesClient
//
//  Created by Kevin Ku on 6/8/14.
//  Copyright (c) 2014 Kevin Ku. All rights reserved.
//

#import <UIImageView+AFNetworking.h>

#import "MovieDetailViewController.h"

@interface MovieDetailViewController ()

@property (nonatomic) id movieData;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterBackground;
@property (weak, nonatomic) IBOutlet UIScrollView *movieDescriptionScrollView;
@property (weak, nonatomic) IBOutlet UIView *movieDescriptionContainerView;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionLabel;

@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithMovieData:(NSString *)nibName bundle:(NSBundle *)nibBundle movieData:(id)data {
    self = [super initWithNibName:nibName bundle:nibBundle];
    if(self) {
        self.movieData = data;
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!self.movieData) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No View Data Found" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        // load movie poster as background
        self.moviePosterBackground.frame = self.view.frame;
        NSURL *imgUrl = [NSURL URLWithString:self.movieData[@"posters"][@"original"]];
        [self.moviePosterBackground setImageWithURL:imgUrl];
        
        [self initScrollView];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)initScrollView {
    // populate description
    [self.movieDescriptionTitleLabel setText:self.movieData[@"title"]];
    [self.movieDescriptionTitleLabel sizeToFit];
    [self.movieDescriptionLabel setText:self.movieData[@"synopsis"]];
    [self.movieDescriptionLabel sizeToFit];
    
    // add description views to container
    [self.movieDescriptionContainerView addSubview:self.movieDescriptionTitleLabel];
    [self.movieDescriptionContainerView addSubview:self.movieDescriptionLabel];
    
    // find the gap between the title label and the description label
    CGFloat gap = self.movieDescriptionLabel.frame.origin.y - (self.movieDescriptionTitleLabel.frame.origin.y + self.movieDescriptionTitleLabel.frame.size.height);
    
    // hack to get the right padding on the bottom of the container for iOS 7 vs iOS 6
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        gap += 20;
    }
    else {
        gap += 50;
    }
    
    // change starting y coordinate and size of the container
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    // start 60% down from the bottom of the navigation bar
    frame.origin.y = (self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height) * 0.6;
    CGSize fitSize = CGSizeMake(self.view.frame.size.width, self.movieDescriptionTitleLabel.frame.size.height + self.movieDescriptionLabel.frame.size.height + gap);
    frame.size = fitSize;
    self.movieDescriptionContainerView.frame = frame;
    
    // add container view to scroll view
    self.movieDescriptionScrollView.frame = self.view.frame;
    [self.movieDescriptionScrollView addSubview:self.movieDescriptionContainerView];
    
    // set content size, taking the starting y coordinate of the container into consideration
    self.movieDescriptionScrollView.contentSize = CGSizeMake(self.movieDescriptionContainerView.frame.size.width, self.movieDescriptionContainerView.frame.size.height + self.movieDescriptionContainerView.frame.origin.y + 20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
