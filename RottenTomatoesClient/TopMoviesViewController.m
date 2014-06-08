//
//  TopMoviesViewController.m
//  RottenTomatoesClient
//
//  Created by Kevin Ku on 6/5/14.
//  Copyright (c) 2014 Kevin Ku. All rights reserved.
//

#import <UIImageView+AFNetworking.h>

#import "BoxOfficeTableViewCell.h"
#import "TopMoviesViewController.h"
#import "MovieDetailViewController.h"

@interface TopMoviesViewController ()

@end

@implementation TopMoviesViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIView *) makeErrorBox:(NSString *)errMsg {
    UIView *errorBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    UITextField *errorTextField = [[UITextField alloc] initWithFrame:errorBox.frame];
    errorTextField.text = errMsg;
    errorTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    errorTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    errorTextField.textAlignment = NSTextAlignmentCenter;
    errorTextField.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    errorTextField.textColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    [errorBox addSubview:errorTextField];
    
    return errorBox;
}

- (void)loadBoxOfficeList {
    // show progress dialog
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD showWithTitle:@"Loading" status:@"Getting Box Office List"];
    
    // async load box office list
    self.rti = [[RottenTomatoesInterface alloc] init];
    RequestCallback successCallback = ^(AFHTTPRequestOperation *op, id data) {
        [self onBoxOfficeListLoaded:op :data];
    };
    ErrorCallback failureCallback = ^(AFHTTPRequestOperation *op, NSError *error) {
        [self onBoxOfficeListLoadError:op :error];
    };
    [self.rti getBoxOfficeList:10 :successCallback :failureCallback];
}

- (void)onBoxOfficeListLoaded:(AFHTTPRequestOperation *)op :(id)data {
    self.boxOfficeList = [data objectForKey:@"movies"];
    
    void (^updateUI)(void) = ^{
        // make sure error box is not showing
        self.tableView.tableHeaderView = nil;
        
        [MMProgressHUD dismiss];
        [self.refreshControl endRefreshing];
        [[self tableView] reloadData];
    };
    
    // update table view
    if([NSThread isMainThread]) {
        updateUI();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), updateUI);
    }
}

- (void)onBoxOfficeListLoadError:(AFHTTPRequestOperation *)op :(NSError *)err {
    NSLog(@"%@", [err localizedDescription]);
    
    [MMProgressHUD dismiss];
    [self.refreshControl endRefreshing];
    self.tableView.tableHeaderView = [self makeErrorBox:@"Network Error!"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Box Office Movies"];
    
    // load box office list
    [self loadBoxOfficeList];
    
    // pull down to refresh feature
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadBoxOfficeList) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.boxOfficeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BoxOfficeTableViewCell";
    BoxOfficeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //cell = [[BoxOfficeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BoxOfficeTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.titleLabel.text = [self.boxOfficeList objectAtIndex:indexPath.row][@"title"];
    cell.descriptionLabel.text = [self.boxOfficeList objectAtIndex:indexPath.row][@"synopsis"];
    
    NSURL *imgUrl = [NSURL URLWithString:[self.boxOfficeList objectAtIndex:indexPath.row][@"posters"][@"thumbnail"]];
    [cell.posterView setImageWithURL:imgUrl];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // open movie detail view
    id data = [self.boxOfficeList objectAtIndex:indexPath.row];
    MovieDetailViewController *detailViewController = [[MovieDetailViewController alloc] initWithMovieData:@"MovieDetailViewController" bundle:nil movieData:data];
    [detailViewController setTitle:data[@"title"]];
    
    [self.navigationController pushViewController:detailViewController animated:true];
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
