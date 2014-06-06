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
@property (nonatomic, copy) RequestCallback successCallback;
@property (nonatomic, copy) ErrorCallback failureCallback;

- (id)initWithCallbacks :(RequestCallback)successCB :(ErrorCallback)failureCB;
- (void)getBoxOfficeList :(int)num;

@end
