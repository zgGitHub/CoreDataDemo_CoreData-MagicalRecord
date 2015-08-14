//
//  ViewController.m
//  CoreDataDemo
//
//  Created by LZXuan on 15-7-21.
//  Copyright (c) 2015年 轩哥. All rights reserved.
//

#import "ViewController.h"

#import "UserModel.h"
#import "CoreData+MagicalRecord.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addClick:(id)sender;
- (IBAction)deleteClick:(id)sender;
- (IBAction)updateClick:(id)sender;
- (IBAction)fetchWithNameClick:(id)sender;
- (IBAction)fetchAllClick:(id)sender;
//数据源数组
@property (nonatomic,strong) NSMutableArray *dataArr;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArr = [[NSMutableArray alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

}
//用CoreData 第三方库 操作的 CoreData
//1。在appDelete 初始化 数据库
//2.增删改查

#pragma mark - 增删改查
//增加
- (IBAction)addClick:(id)sender {
    //向 数据库增加一个对象 MR_createEntity是给NSManagedObject增加的类别  子类是可以用的
    UserModel *model = [UserModel MR_createEntity];
    model.name = self.name.text;
    model.fName = [self.name.text substringToIndex:1];
    model.age = @(self.age.text.integerValue);
    
    //增删改数据之后 都要保存数据
    //保存到数据库
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}
//删除
- (IBAction)deleteClick:(id)sender {
   //先 查找
    //根据名字查找 第一个参数 是 UserModel的属性名字
    // 第二个参数就是 属性的值
    NSArray *arr = [UserModel MR_findByAttribute:@"name" withValue:self.name.text];
    //遍历数组
    for (UserModel *model in arr) {
        //从数据库删除(内存上删除)
        [model MR_deleteEntity];
    }
    //保存数据库-》写磁盘
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    //[UserModel MR_findFirst];//查找第一个
}

- (IBAction)updateClick:(id)sender {
    //先 查找

    NSArray *arr = [UserModel MR_findByAttribute:@"name" withValue:self.name.text];
    //遍历数组
    for (UserModel *model in arr) {
        model.age = @(self.age.text.integerValue);
    }
    //修改之后保存数据库-》写磁盘
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)fetchWithNameClick:(id)sender {
    /**
     *  根据名字查找
     */
    NSArray *arr = [UserModel MR_findByAttribute:@"name" withValue:self.name.text];
    //
    [self.dataArr removeAllObjects];
    //增加新数据
    [self.dataArr addObjectsFromArray:arr];
    //刷新表格
    [self.tableView reloadData];
}

- (IBAction)fetchAllClick:(id)sender {
   //NSArray *arr = [UserModel MR_findAll];//查找所有不排序
    //查找所有 按照age 降序
    NSArray *arr = [UserModel MR_findAllSortedBy:@"age" ascending:NO];
    
    [self.dataArr removeAllObjects];
    //增加新数据
    [self.dataArr addObjectsFromArray:arr];
    //刷新表格
    [self.tableView reloadData];
}
#pragma mark - UITableView协议
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UserModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"name:%@ age:%ld",model.name,model.age.integerValue];
    return cell;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.name resignFirstResponder];
    [self.age resignFirstResponder];
}


@end








