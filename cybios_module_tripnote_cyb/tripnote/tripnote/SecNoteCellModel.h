//
//  SecNoteCellModel.h
//  tripnote
//
//  Created by wanghe on 15-5-18.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entity.h"
@interface SecNoteCellModel : Entity
@property (nonatomic,strong) NSString* tripid;
@property (nonatomic,strong) NSString* cid;
@property (nonatomic,strong) NSString* notebody;
@property (nonatomic,strong) NSString* logdate;
@property (nonatomic,strong) NSMutableArray* imgurls;

@end
