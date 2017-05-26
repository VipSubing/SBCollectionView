//
//  FirstViewController.m
//  SBCollectionView
//
//  Created by qyb on 2017/5/26.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "FirstViewController.h"
#import "SBCollectionView.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface FirstViewController ()
{
    NSInteger _index;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    // Do any additional setup after loading the view.
    _index = 13;
    
    SBCollectionView *sb = [[SBCollectionView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) itemCount:^NSInteger(SBCollectionView *cv) {
        return _index;
    } itemSize:CGSizeMake(Screen_Width/4, Screen_Width/4) item:^UIView *(SBCollectionView *cv, NSIndexPath *indexPath) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        return label;
    } reloadItem:^UIView *(SBCollectionView *cv, UIView *item, NSIndexPath *indexPath) {
        UILabel *label = item;
        label.backgroundColor = [self randomColor];
        label.text = [NSString stringWithFormat:@"%d",indexPath.row];
        return label;
    } didSelectItem:^(SBCollectionView *cv, NSIndexPath *indexPath) {
        NSLog(@"%@",indexPath);
    }];
    [self.view addSubview:sb];
    [sb reloadData];
    
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
