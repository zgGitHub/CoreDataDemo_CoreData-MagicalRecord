//
//  UserModel.m
//  CoreDataDemo
//
//  Created by LZXuan on 15-7-21.
//  Copyright (c) 2015年 轩哥. All rights reserved.
//

#import "UserModel.h"


@implementation UserModel

/*
 在声明property属性后，有2种实现选择
 @synthesize
 编译器期间，让编译器自动生成getter/setter方法。
 当有自定义的存或取方法时，自定义会屏蔽自动生成该方法
 
 @dynamic
 告诉编译器，不自动生成getter/setter方法，避免编译期间产生警告
 然后由自己实现存取方法
 或存取方法在运行时动态创建绑定：主要使用在CoreData的实现NSManagedObject子类时使用，由Core Data框架在程序运行的时动态生成子类属性
 */
/*
 
 @dynamic这个关键词，通常是用不到的。
 它与@synthesize的区别在于：
 
 使用@synthesize编译器会确实的产生getter和setter方法，而@dynamic仅仅是告诉编译器这两个方法在运行期会有的，无需产生警告。
 */


@dynamic age;
@dynamic name;
@dynamic fName;

@end









