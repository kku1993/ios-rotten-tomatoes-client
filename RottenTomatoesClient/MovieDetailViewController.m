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
@property (weak, nonatomic) IBOutlet UITextView *movieDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIView *movieDescriptionContainerView;
@property (weak, nonatomic) IBOutlet UILabel *movieDescriptionTitleLabel;

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
    }
}

- (void)updateFrameSize:(UIView *)view :(CGSize)size {
    CGRect newFrame = view.frame;
    newFrame.size = size;
    view.frame = newFrame;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // populate description
    self.movieDescriptionTitleLabel.text = self.movieData[@"title"];
    [self.movieDescriptionTextView setText:self.movieData[@"synopsis"]];
    
    // add description views to container
    [self.movieDescriptionContainerView addSubview:self.movieDescriptionTitleLabel];
    [self.movieDescriptionContainerView addSubview:self.movieDescriptionTextView];
    
    // add container view to scroll view
    self.movieDescriptionScrollView.frame = self.view.frame;
    [self.movieDescriptionScrollView addSubview:self.movieDescriptionContainerView];
    
    // update textview frame size
    CGSize fitSize = [self.movieDescriptionTextView sizeThatFits:CGSizeMake(self.movieDescriptionTextView.frame.size.width, MAXFLOAT)];
    [self updateFrameSize:self.movieDescriptionTextView :fitSize];
    self.movieDescriptionTextView.contentSize = fitSize;
    
    // update container frame size
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.movieDescriptionTitleLabel.frame.size.height + fitSize.height;
    [self updateFrameSize:self.movieDescriptionContainerView :CGSizeMake(width, height)];
    
    // set content size of scroll view
    self.movieDescriptionScrollView.contentSize = CGSizeMake(width, height + self.movieDescriptionContainerView.frame.origin.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
