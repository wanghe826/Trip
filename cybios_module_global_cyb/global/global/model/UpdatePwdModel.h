//
//  UpdatePwdModel.h
//  global
//
//  Created by jbas on 15/4/29.
//  Copyright (c) 2015年 cyb. All rights reserved.
//

#import "Entity.h"

@interface UpdatePwdModel : Entity
@property(strong,nonatomic) NSString *account;
@property(strong,nonatomic) NSString *oldpwd;
@property(strong,nonatomic) NSString *pwd;

@end
