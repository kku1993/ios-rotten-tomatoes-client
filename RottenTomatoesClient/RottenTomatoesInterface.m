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

- (void)httpGet :(NSString *)url :(RequestCallback)successCB :(ErrorCallback)failureCB {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:successCB failure:failureCB];
}

- (void)getBoxOfficeList :(int)num :(RequestCallback)successCB :(ErrorCallback)failureCB {
    NSString *boxOfficeUrl = self.boxOfficeUrl;
    boxOfficeUrl = [boxOfficeUrl stringByReplacingOccurrencesOfString:@"{num}" withString:[NSString stringWithFormat:@"%i", num]];

    if(successCB && failureCB) {
        [self httpGet:boxOfficeUrl :successCB :failureCB];
    }
    else {
        [NSException raise:@"No callback provided" format:@"No callback provided"];
    }
}

@end
