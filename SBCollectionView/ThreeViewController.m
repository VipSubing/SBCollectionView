//
//  ThreeViewController.m
//  SBCollectionView
//
//  Created by qyb on 2017/5/26.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "ThreeViewController.h"
#import "SBCollectionView.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface ThreeViewController ()
{
    NSArray *_titles;
    NSArray *_imageNames;
}
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _titles = @[@"红包",@"转账",@"充值",@"机票",@"淘票票",@"滴滴出行",@"我的快递",@"全部"];
    _imageNames = @[@"function_red",@"function_zhuanzhang",@"function_chongzhi",@"function_jipiao",@"function_taopiao",@"function_chuxing",@"function_kuaidi",@"function_all"];
//    __weak typeof(self) weak = self;
    SBCollectionView *sb = [[SBCollectionView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) itemCount:^NSInteger(SBCollectionView *cv) {
        return _imageNames.count;
    } itemSize:CGSizeMake(Screen_Width/4, Screen_Width/4) item:^UIView *(SBCollectionView *cv, NSIndexPath *indexPath) {
        return [self item];
    } reloadItem:^UIView *(SBCollectionView *cv, UIView *item, NSIndexPath *indexPath) {
        return [self reloadItem:item indexpath:indexPath];
    } didSelectItem:^(SBCollectionView *cv, NSIndexPath *indexPath) {
        NSLog(@"点击 %@",_titles[indexPath.row]);
    }];
    [sb reloadData];
    [self.view addSubview:sb];
}
- (UIView *)reloadItem:(UIView *)item indexpath:(NSIndexPath *)indexPath{
    UIImageView *icon = [item viewWithTag:11];
    icon.image = [UIImage imageNamed:_imageNames[indexPath.row]];
    UILabel *title = [item viewWithTag:12];
    title.text = _titles[indexPath.row];
    return item;
}
- (UIView *)item{
    UIView *item = [[UIView alloc]init];
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/11, Screen_Width/10)];
    icon.tag = 11;
    icon.center = CGPointMake(Screen_Width/8, Screen_Width/8-20);
    [item addSubview:icon];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(icon.frame), Screen_Width/4, 20)];
    title.textColor = [UIColor blackColor];
    title.font = [UIFont systemFontOfSize:14];
    title.textAlignment = NSTextAlignmentCenter;
    title.tag  =12;
    [item addSubview:title];
    return item;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
