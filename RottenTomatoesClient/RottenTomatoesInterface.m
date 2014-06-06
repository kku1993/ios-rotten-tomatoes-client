//
//  RottenTomatoesInterface.m
//  RottenTomatoesClient
//
//  Created by Kevin Ku on 6/5/14.
//  Copyright (c) 2014 Kevin Ku. All rights reserved.
//

#import "RottenTomatoesInterface.h"

@implementation RottenTomatoesInterface

- (id)init {
    self = [super init];
    if(self) {
        // get values required for rotten tomatoes api
        NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
        NSDictionary *config = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        self.apiKey = config[@"rt_api_key"];
        
        NSString *boxOfficeUrl = config[@"rt_box_office_url"];
        self.boxOfficeUrl = [boxOfficeUrl stringByReplacingOccurrencesOfString:@"{api_key}" withString:[NSString stringWithFormat:@"%@", self.apiKey]];
    }
    return self;
}

- (id)initWithCallbacks :(RequestCallback)successCB :(ErrorCallback)failureCB {
    self = [self init];
    self.successCallback = successCB;
    self.failureCallback = failureCB;
    return self;
}

- (void)httpGet :(NSString *)url {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:self.successCallback failure:self.failureCallback];
}

- (void)getBoxOfficeList :(int)num {
    NSString *boxOfficeUrl = self.boxOfficeUrl;
    boxOfficeUrl = [boxOfficeUrl stringByReplacingOccurrencesOfString:@"{num}" withString:[NSString stringWithFormat:@"%i", num]];

    if(self.successCallback && self.failureCallback) {
        [self httpGet:boxOfficeUrl];
    }
    else {
        [NSException raise:@"No callback provided" format:@"No callback provided"];
    }
}

@end
