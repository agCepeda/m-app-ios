//
//  Review.h
//  Meishii
//
//  Created by Develop Mx on 16/09/16.
//  Copyright © 2016 Develop Mx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy) NSString *reviewerName;

- (id) initWithDictionary: (NSDictionary *) dictionary;

@end
