//
//  ABCenterCoreDataManager.h
//  AccountBook
//
//  Created by zhourongqing on 15/10/16.
//  Copyright © 2015年 mtry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABCenterCoreDataManager : NSObject

///查询分类列表数据
- (NSArray *)selectCategoryListData:(BOOL)isSelectRemoved;

///增加分类
- (void)insertCategoryModel:(ABCategoryModel *)model;

///删除分类
- (void)deleteCategoryCategoryID:(NSString *)categoryID;

///修改分类(如果没有就插入)
- (void)updateCategoryModel:(ABCategoryModel *)model;


///查询全部消费纪录
- (NSArray *)selectChargeListData;

///查询消费列表
- (NSArray *)selectChargeListDateWithCategoryID:(NSString *)categoryID;

///增加消费记录
- (void)insertChargeModel:(ABChargeModel *)model;

///删除消费记录
- (void)deleteChargeChargeID:(NSString *)chargeID;

///删除消费列表纪录
- (void)deleteChargeListDataWithCategoryID:(NSString *)categoryID;

///修改消费记录
- (void)updateChargeModel:(ABChargeModel *)model;

@end
