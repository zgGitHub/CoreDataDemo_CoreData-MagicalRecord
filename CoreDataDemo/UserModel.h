//
//  UserModel.h
//  CoreDataDemo
//
//  Created by LZXuan on 15-7-21.
//  Copyright (c) 2015年 轩哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserModel : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * fName;

@end
