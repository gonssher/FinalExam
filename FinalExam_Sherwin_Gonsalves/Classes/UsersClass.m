//
//  UsersClass.m
//  FinalExam_Sherwin_Gonsalves
//
//  Created by Sherwin on 2020-03-31.
//  Copyright © 2020 Sherwin. All rights reserved.
//

#import "UsersClass.h"

@implementation UsersClass



-(instancetype) init:(int)Id name:(NSString *)name age:(int)Age avatar:(NSString*)avatar{
     if((self = [super init]))
    {
        self.Age= Age;
        self.avatar = avatar;
        self.name = name;
        self.Id = Id;
        
        
    }
    return self;
    
}



@end
