//
//  FourViewController.m
//  SBCollectionView
//
//  Created by qyb on 2017/5/26.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "FourViewController.h"
#import "SBCollectionView.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface FourViewController ()
{
    NSInteger _index;
    NSArray *_titles;
    
}
@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    _index = 12;
    _titles = @[@"点我删除",@"夏季卫衣",@"跑鞋",@"nike",@"游泳圈",@"房车",@"跑车",@"冬季棉衣",@"点我添加"];
    _index = _titles.count-1;
    SBCollectionView *sb = [[SBCollectionView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) itemCount:^NSInteger(SBCollectionView *cv) {
        return _titles.count;
    } itemSize:CGSizeMake(Screen_Width/4, Screen_Width/4) item:^UIView *(SBCollectionView *cv, NSIndexPath *indexPath) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blueColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.font = [UIFont systemFontOfSize:15];
        return label;
    } reloadItem:^UIView *(SBCollectionView *cv, UIView *item, NSIndexPath *indexPath) {
        UILabel *label = item;
        label.backgroundColor = [self randomColor];
        label.text = _titles[indexPath.row];
        return label;
    } didSelectItem:^(SBCollectionView *cv, NSIndexPath *indexPath) {
        if (indexPath.row == 0) {
            [cv deleteItemAtIndexPath:indexPath animated:YES completion:^(NSInteger count) {
                _index = count-1;
                [cv reloadItemAtIndexPath:indexPath];
            }];
        }
        if (indexPath.row == _index) {
            [cv insertItemsOfCount:1 AtIndexPath:indexPath animated:YES completion:^(UIView *item, NSInteger count) {
                UILabel *label = item;
                label.text = [self addTitle];
                label.backgroundColor = [self randomColor];
                
                NSLog(@"当前item的个数 ： %d",count);
                _index = count-1;
            }];
        }
    }];
    sb.contentInset = UIEdgeInsetsMake(10, 20, 0, 20);
    sb.minHorizontalSpace = 20;
    sb.verticalSpace = 10;
    [self.view addSubview:sb];
    [sb reloadData];
}
- (NSString *)addTitle{
    int rand = arc4random()%_titles.count;
    if (rand == _titles.count-1) {
        rand = _titles.count-2;
    }
    return _titles[rand];
}
- (UIColor *)randomColor{
    UIColor *color = [UIColor colorWithRed:[self random]/255.f green:[self random]/255.f blue:[self random]/255.f alpha:1];
    return color;
}
- (float)random{
    return arc4random()%255+1;
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
