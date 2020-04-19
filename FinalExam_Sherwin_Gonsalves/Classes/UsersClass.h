//
//  UsersClass.h
//  FinalExam_Sherwin_Gonsalves
//
//  Created by Sherwin on 2020-03-31.
//  Copyright © 2020 Sherwin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UsersClass : NSObject


@property(assign) int Age;
@property(strong,nonatomic) NSString *name;
@property(assign) int Id;
@property(strong,nonatomic) NSString *avatar;



-(instancetype) init:(int)Id name:(NSString *)name age:(int)Age avatar:(NSString*)avatar ;


@end



NS_ASSUME_NONNULL_END
//init(row: Int, name: String, age: Int, avatar : String) {
  //  self.id = row
   // self.name = name
    //self.age = age
    //self.avatar = avatar
//}
