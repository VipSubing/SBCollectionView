//
//  DetailViewController.m
//  SBCollectionView
//
//  Created by qyb on 2017/5/26.
//  Copyright © 2017年 qyb. All rights reserved.
//

#import "DetailViewController.h"
#import "SBCollectionView.h"
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
@interface DetailViewController ()<SBCollectionProtocol>
{
    NSArray *_images;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    _images = @[@"timg.jpeg",@"timg-7.jpeg",@"timg-2.jpeg",@"timg-3.jpeg",@"timg-4.jpeg",@"timg-5.jpeg",@"timg-6.jpeg"];
    SBCollectionView *sb = [[SBCollectionView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64) itemSize:CGSizeMake(Screen_Width/4, Screen_Width/4) delegate:self];
    [sb reloadData];
    [self.view addSubview:sb];
}
- (NSInteger)itemsCountForCollectionView:(SBCollectionView *)cv{
    return _images.count;
}
- (UIView *)collectionView:(SBCollectionView *)cv itemInitAtIndexPath:(NSIndexPath *)indexPath{
    UIImageView *image = [[UIImageView alloc] init];
    return image;
}
- (UIView *)collectionView:(SBCollectionView *)cv drawedObject:(UIView *)object indexPath:(NSIndexPath *)indexPath{
    UIImageView *image = object;
    UIImage *pb_image = [UIImage imageNamed:_images[indexPath.row]];
    image.image = pb_image;
    return image;
}
- (SBColletionLayout *)layoutsForCollectionView:(SBCollectionView *)cv layout:(SBColletionLayout *)layout indexPath:(NSIndexPath *)indexPath{
    //通过设置layout.frame 达到自定义布局的目的
//    layout.frame;
    return layout;
}
- (void)collectionView:(SBCollectionView *)cv didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSLog(@"%@",indexPath);
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
