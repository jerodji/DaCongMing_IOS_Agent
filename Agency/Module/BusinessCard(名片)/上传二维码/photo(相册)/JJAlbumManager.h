//
//  JJAlbumManager.h
//  Agency
//
//  Created by hailin on 2018/2/6.
//  Copyright © 2018年 Jerod. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

/**
 * 相册模型
 */
@interface AlbumModel : NSObject
@property (nonatomic, copy)   NSString * title; //相册名字
@property (nonatomic, assign) NSInteger  count; //该相册内相片数量
@property (nonatomic, strong) PHAsset * headImageAsset; //相册第一张图片缩略图
@property (nonatomic, strong) PHAssetCollection * assetCollection; //相册集，通过该属性获取该相册集下所有照片
@end


/**
 * 系统相册工具,iOS 8+
 */
@interface JJAlbumManager : NSObject

+ (instancetype)sharedInstance;

/**
 * @brief 获取用户所有相册列表
 */
- (NSArray<AlbumModel *> *)getPhotoAblumList;

/**
 * @brief 获取相册内所有图片资源
 * @param ascending 是否按创建时间正序排列 YES,创建时间正（升）序排列; NO,创建时间倒（降）序排列
 */
- (NSArray<PHAsset *> *)getAllAssetInPhotoAblumWithAscending:(BOOL)ascending;

/**
 * @brief 获取指定相册内的所有图片
 */
- (NSArray<PHAsset *> *)getAssetsInAssetCollection:(PHAssetCollection *)assetCollection ascending:(BOOL)ascending;

/**
 * @brief 获取每个Asset对应的图片
 */
- (void)requestImageForAsset:(PHAsset *)asset size:(CGSize)size resizeMode:(PHImageRequestOptionsResizeMode)resizeMode completion:(void (^)(UIImage *image))completion;

@end
