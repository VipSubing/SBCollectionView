//
//  FiveViewController.m
//  SBCollectionView
//
//  Created by qyb on 2017/5/26.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "FiveViewController.h"
#import "SBCollectionView.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface FiveViewController ()
{
    NSArray *_images;
}
@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _images = @[@"timg.jpeg",@"timg-7.jpeg",@"timg-2.jpeg",@"timg-3.jpeg",@"timg-4.jpeg",@"timg-5.jpeg",@"timg-6.jpeg"];
    SBCollectionView *sb = [[SBCollectionView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) itemCount:^NSInteger(SBCollectionView *cv) {
        return _images.count;
    } itemSize:CGSizeMake(Screen_Width/4, Screen_Width/4) item:^UIView *(SBCollectionView *cv, NSIndexPath *indexPath) {
        UIImageView *image = [[UIImageView alloc] init];
        return image;
    } reloadItem:^UIView *(SBCollectionView *cv, UIView *item, NSIndexPath *indexPath) {
        UIImageView *image = item;
        UIImage *pb_image = [UIImage imageNamed:_images[indexPath.row]];
        image.image = pb_image;
        return image;
    } didSelectItem:^(SBCollectionView *cv, NSIndexPath *indexPath) {
        
    }];
    [self.view addSubview:sb];
    [sb reloadData];
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
