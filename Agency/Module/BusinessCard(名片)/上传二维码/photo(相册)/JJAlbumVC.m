//
//  JJAlbumVC.m
//  Agency
//
//  Created by hailin on 2018/2/6.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import "JJAlbumVC.h"

@interface JJAlbumVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,retain) NSMutableArray * dataArr;
@end

@implementation JJAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [[NSMutableArray alloc]init];
    self.title = @"选择二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancleAction)];
    
    //调用这个方法获取相册里的所有图片
    [_dataArr addObjectsFromArray:[[JJAlbumManager sharedInstance] getAllAssetInPhotoAblumWithAscending:NO]];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 5; /* 同一行相邻两个cell的最小间距 */
    layout.minimumLineSpacing = 5; /* 最小两行之间的间距 */
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(5, 5, ScreenWidth - 10, ScreenHeight - NavHeight - StatusHeight - 5 - HomebarHeight - 5) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;/* 这个是横向滑动 */
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photocellid"];
}

- (void)cancleAction {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"photocellid" forIndexPath:indexPath];
    PHAsset *asset = _dataArr[indexPath.row];
    [self getImageWithAsset:asset completion:^(UIImage *image) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.photo.image = image;
    }];
    return cell;
}
//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat wid = (ScreenWidth-5*5)/4;
    return CGSizeMake(wid, wid);
}
//从这个回调中获取所有的图片
- (void)getImageWithAsset:(PHAsset *)asset completion:(void (^)(UIImage *image))completion
{
    CGSize size = [self getSizeWithAsset:asset];
    [[JJAlbumManager sharedInstance] requestImageForAsset:asset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:completion];
}
#pragma mark - 获取图片及图片尺寸的相关方法
- (CGSize)getSizeWithAsset:(PHAsset *)asset
{
    CGFloat width  = (CGFloat)asset.pixelWidth;
    CGFloat height = (CGFloat)asset.pixelHeight;
    CGFloat scale = width/height;
    
    return CGSizeMake(self.collectionView.frame.size.height*scale, self.collectionView.frame.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld , %@",indexPath.row, _dataArr[indexPath.row]);
    PHAsset * phasset = _dataArr[indexPath.row];
    !_qrSelectedCB ? : _qrSelectedCB(phasset);
}


@end



#pragma mark - /********************** PhotoCell **********************/

@implementation PhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _photo = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_photo];
}

@end
