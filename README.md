# SBCollectionView 1.0.0
### 作者邮箱：15557109308@163.com 有问题可以联系作者
##### 作者常常需要在项目用到Item集合这样的布局方式，单是用UICollectionView去做发现代码很多而且不好自定义，所以花了一些时间写了专门处理
##### 这种item集合的一套框架.
##### 仿UICollectionView的布局方式，适用于少量有限的Item集合。支持了UICollectionVIew主要部分的操作，刷新，增，删。
##### 相较于UICollectionView的优势:
##### 1.简易快捷轻便，可以用block或代理的方式快速的搭建高度自定义的CollectionView布局
##### 2.框架更轻量级，因为取消了滑动相关，两个层级的UIview相比UICollectionView复杂的视图层级更轻便.
##### 3.灵活的布局能力，可以方便的定义item的大小，delegate提供了一套自定义的布局方法。
##### 下面是效果图:
##### ![image](https://github.com/pubin563783417/SBCollectionView/tree/master/Screenshot/pb_1.png)
##### ![image](https://github.com/pubin563783417/SBCollectionView/tree/master/Screenshot/pb_2.png)
##### ![image](https://github.com/pubin563783417/SBCollectionView/tree/master/Screenshot/pb_3.png)
##### ![image](https://github.com/pubin563783417/SBCollectionView/tree/master/Screenshot/pb_4.png)
##### ![image](https://github.com/pubin563783417/SBCollectionView/tree/master/Screenshot/Untitled.gif)
##### 框架提供了两套布局方式 block和delegate
##### 注意://代理的优先级将会高于block
##### /**
 ##### 通过block控制的实例化
 ##### @param frame sbcollectionview.frame
#####  @param itemCount itemCount
 ##### @param itemSize item 的大小 size
 ##### @param item 通过item获取一个item
 ##### @param reloadItem 刷新item
 ##### @param didSelectItem 选择item的回调
#####  @return sbcollectionview
 */
##### - (instancetype)initWithFrame:(CGRect)frame itemCount:(CountBlock)itemCount itemSize:(CGSize) 
##### itemSize item:(ItemBlock)item reloadItem:(ReloadBlock)reloadItem  didSelectItem:(DidSelectBlock)didSelectItem;
##### /**
#####  通过代理方式实例化

#####  @param frame frame
#####  @param itemSize item的大小
#####  @param delegate 代理
#####  @return sbcollectionview
#####  */
##### - (instancetype)initWithFrame:(CGRect)frame itemSize:(CGSize)itemSize ### delegate:(id <SBCollectionProtocol>)delegate;

