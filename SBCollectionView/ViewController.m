//
//  ViewController.m
//  SBCollectionView
//
//  Created by qyb on 2017/5/26.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ViewController.h"
#import "SBCollectionView.h"
#import "FirstViewController.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<SBCollectionProtocol>
@property (strong,nonatomic) NSArray *datas;
@property (strong,nonatomic) NSArray *vcs;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    _datas = @[@"block快捷方式创建",@"delegate方式创建",@"支付宝首页",@"标签添加和删除操作",@"图片",@"自定义layout布局"];
    _vcs = @[@"FirstViewController",@"SecondViewController",@"ThreeViewController",@"FourViewController",@"FiveViewController",@""];
    SBCollectionView *sb = [[SBCollectionView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) itemSize:CGSizeMake(Screen_Width, 60) delegate:self];
    [self.view addSubview:sb];
    [sb reloadData];
}
- (NSInteger)itemsCountForCollectionView:(SBCollectionView *)cv{
    return _datas.count;
}
- (void)collectionView:(SBCollectionView *)cv didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[self nextVCWithIndexPath:indexPath] animated:YES];
}
- (UIView *)collectionView:(SBCollectionView *)cv itemInitAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blueColor];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    return label;
}

- (UIView *)collectionView:(SBCollectionView *)cv drawedObject:(UIView *)object indexPath:(NSIndexPath *)indexPath{
    UILabel *label = object;
    label.text = _datas[indexPath.row];
    return label;
}
- (UIViewController *)nextVCWithIndexPath:(NSIndexPath *)indexPath{
    Class class = NSClassFromString(_vcs[indexPath.row]);
    UIViewController *vc = [[class alloc] init];
    vc.title = _datas[indexPath.row];
    return vc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
