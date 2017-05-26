//
//  SecondViewController.m
//  SBCollectionView
//
//  Created by qyb on 2017/5/26.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "SecondViewController.h"
#import "SBCollectionView.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface SecondViewController ()<SBCollectionProtocol>
{
    NSInteger _count;
}
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _count = 12;
    self.view.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    SBCollectionView *sb = [[SBCollectionView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) itemSize:CGSizeMake(Screen_Width/5, Screen_Width/5) delegate:self];
    sb.contentInset = UIEdgeInsetsMake(20, 20, 0, 20);
    sb.minHorizontalSpace = 5;
    sb.verticalSpace = 5;
    [self.view addSubview:sb];
    [sb reloadData];
}
- (NSInteger)itemsCountForCollectionView:(SBCollectionView *)cv{
    return _count;
}
- (UIView *)collectionView:(SBCollectionView *)cv itemInitAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    return label;
}
- (UIView *)collectionView:(SBCollectionView *)cv drawedObject:(UIView *)object indexPath:(NSIndexPath *)indexPath{
    UILabel *label = object;
    label.backgroundColor = [self randomColor];
    label.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return label;
}
- (void)collectionView:(SBCollectionView *)cv didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
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
