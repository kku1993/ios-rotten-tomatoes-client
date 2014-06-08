//
//  RottenTomatoesInterface.h
//  RottenTomatoesClient
//
//  Created by Kevin Ku on 6/5/14.
//  Copyright (c) 2014 Kevin Ku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface RottenTomatoesInterface : NSObject

typedef void(^RequestCallback)(AFHTTPRequestOperation *operation, id data);
typedef void(^ErrorCallback)(AFHTTPRequestOperation *operation, NSError * error);

@property (nonatomic) NSString *apiKey;
@property (nonatomic) NSString *boxOfficeUrl;
@property (nonatomic) NSString *topDVDUrl;

- (void)getBoxOfficeList:(int)num :(RequestCallback)successCB :(ErrorCallback)failureCB;
- (void)getTopDVDList:(int)num :(RequestCallback)successCB :(ErrorCallback)failureCB;

@end
