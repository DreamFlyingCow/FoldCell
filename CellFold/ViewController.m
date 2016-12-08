//
//  ViewController.m
//  CellFold
//
//  Created by 赵春浩 on 16/12/8.
//  Copyright © 2016年 Mr Zhao. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Size.h"
#import "TTCustomCell.h"

static NSString *reuseID = @"ViewControllerCell";
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  存放每个cell上的文字
 */
@property (strong, nonatomic) NSArray *dataArr;
/**
 *  存放每个cell的高度
 */
@property (strong, nonatomic) NSMutableArray *cellHeightArr;
/**
 *  用来存放cell是否被打开(或折叠)
 */
@property (strong, nonatomic) NSMutableArray *isCellFold;

@end

@implementation ViewController

- (NSMutableArray *)cellHeightArr {
    
    if (_cellHeightArr == nil) {
        _cellHeightArr = [NSMutableArray array];
        for (int i = 0; i < self.dataArr.count; i ++) {
            // 初始cell的高度是44(自定义设置), 这个高度也就是cell折叠之后的高度
            [_cellHeightArr addObject:@"44"];
        }
    }
    return _cellHeightArr;
}

- (NSMutableArray *)isCellFold {
    
    if (_isCellFold == nil) {
        _isCellFold = [NSMutableArray array];
        for (int i = 0; i < self.dataArr.count; i ++) {
            // 初始化赋值为1, 表示cell被折叠了(0 表示cell被打开了)
            [_isCellFold addObject:@"1"];
        }
    }
    return _isCellFold;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"TTCustomCell" bundle:nil] forCellReuseIdentifier:reuseID];
    _dataArr = @[@"静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问",@"（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。",@"静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问",@"（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。",@"静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问",@"（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。",@"静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问",@"（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。",@"静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问静态变量使用 static 修饰符进行声明，在类被实例化时创建，通过类和对象都可以进行访问",@"（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。（2）static成员函数既可以在类的内部定义，也可以在类的外部定义，在外部定义时，不能重复指定static保留字。"];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.label.text = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self.cellHeightArr[indexPath.row] floatValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.isCellFold[indexPath.row] isEqualToString:@"1"]) {// 此时cell是被折叠的, 需要被打开
        // 改标记
        self.isCellFold[indexPath.row] = @"0";
        NSString *str = self.dataArr[indexPath.row];
        // 计算文字所需要的高度
        CGSize size = [str boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 0) withFont:[UIFont systemFontOfSize:17]];
        // 保存文字所需要的高度
        self.cellHeightArr[indexPath.row] = [NSString stringWithFormat:@"%f", size.height + 10];
    } else {
        // 改标记
        self.isCellFold[indexPath.row] = @"1";
        // 恢复为原来的高度(也就是初始时设置的折叠的高度)
        self.cellHeightArr[indexPath.row] = @"44";
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

@end
