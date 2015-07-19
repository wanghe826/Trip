//
//  CYBAdviceReply.h
//  global
//
//  Created by wanghe on 15-5-13.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"

@interface CYBAdviceReply : Entity
@property (nonatomic,strong) NSString* _id;
@property (nonatomic,strong) NSString* replycomments;
@property (nonatomic,strong) NSMutableArray* imgurls;
@property (nonatomic,strong) NSString* replycid;
@property (nonatomic,strong) NSString* replytype;

@end
