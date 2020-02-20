//
//  XMGalleryModel.h
//  Advertising
//
//  Created by dingqiankun on 2019/12/17.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 类目
@interface XMGalleryCateItemModel : NSObject

@property(nonatomic, copy)NSString *title;

@property(nonatomic, assign)NSInteger Id;

@end

@interface XMGalleryCateModel : NSObject

@property(nonatomic, strong)NSArray<XMGalleryCateItemModel *> *data;

@end



// 默认

@interface XMGallerySelectModel : NSObject

@property(nonatomic, copy)NSString *areaCode;  // 地区编码

@property(nonatomic, assign)NSInteger areaType;  // 地区类型

@property(nonatomic, assign)NSInteger categoryId;  // 分类ID

@end


// 类目列表

@interface XMCategoryListItemModel : NSObject

@property(nonatomic, copy)NSString *desc;   //

@property(nonatomic, copy)NSString *bannerPath;

@property(nonatomic, assign)NSInteger views;

@property(nonatomic, assign)NSInteger Id;

@end

@interface XMCategoryListModel : NSObject

@property(nonatomic, strong)NSMutableArray<XMCategoryListItemModel *> *records;   //

@end




NS_ASSUME_NONNULL_END
