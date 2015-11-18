//
//  ABCategoryDataManger.m
//  AccountBook
//
//  Created by zhourongqing on 15/9/19.
//  Copyright (c) 2015年 mtry. All rights reserved.
//

#import "ABCategoryDataManger.h"

@interface ABCategoryDataManger()<ABCenterDataManagerDelegate>

@property (nonatomic, strong) NSMutableArray *listItem;

@end

@implementation ABCategoryDataManger

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [[ABCenterDataManager share].callBackUtils addDelegate:self];
    }
    return self;
}

- (NSMutableArray *)listItem
{
    if(!_listItem)
    {
        _listItem = [NSMutableArray array];
    }
    return _listItem;
}

- (void)requestInitData;
{
    [[ABCenterDataManager share] requestCategoryListData];
}

- (NSInteger)numberOfItem
{
    return self.listItem.count;
}

- (ABCategoryModel *)dataAtIndex:(NSInteger)index
{
    if(index < [self numberOfItem])
    {
        return self.listItem[index];
    }
    return nil;
}

- (void)requestAddObjectWithText:(NSString *)text
{
    if(text.length)
    {
        ABCategoryModel *model = [[ABCategoryModel alloc] init];
        model.categoryID = [ABUtils uuid];
        model.name = text;
        model.colorHexString = [self colorHexString];
        
        [[ABCenterDataManager share] requestCategoryAddModel:[model copy]];
        
        [self.listItem addObject:model];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.numberOfItem - 1 inSection:0];
        [self.callBackUtils callBackAction:@selector(dataManager:addIndexPath:) object1:self object2:indexPath];
    }
}

- (void)requestRemoveIndex:(NSInteger)index
{
    if(index < [self numberOfItem])
    {
        ABCategoryModel *model = [self dataAtIndex:index];
        [[ABCenterDataManager share] requestCategoryRemoveCategoryId:model.categoryID];
        
        [self.listItem removeObjectAtIndex:index];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.callBackUtils callBackAction:@selector(dataManager:removeIndexPath:) object1:self object2:indexPath];
    }
}

- (void)requestRename:(NSString *)text atIndex:(NSInteger)index
{
    text = [text trim];
    if(text.length == 0)
    {
        text = @" ";
    }
    
    ABCategoryModel *model = [self dataAtIndex:index];
    if(model)
    {
        model.name = text;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        [self.callBackUtils callBackAction:@selector(dataManager:updateIndexPath:) object1:self object2:indexPath];
        
        [[ABCenterDataManager share] requestCategoryUpdateModel:model.copy];
    }
}

- (void)requestMoveItemAtIndex:(NSInteger)index toIndex:(NSInteger)toIndex
{
    id object = self.listItem[index];
    [self.listItem removeObjectAtIndex:index];
    [self.listItem insertObject:object atIndex:toIndex];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSIndexPath *toIndexPath = [NSIndexPath indexPathForRow:toIndex inSection:0];
    [self.callBackUtils callBackAction:@selector(categoryDataManger:moveItemAtIndexPath:toIndexPath:) object1:self object2:indexPath object3:toIndexPath];
}

- (NSString *)colorHexString
{
    NSArray *colors = @[@"0x43A7CA", @"0xF75978", @"0xE9B043", @"0x5DC26D", @"0xB26DAD", @"0xD19459", @"0x6395c5", @"0x98BF58", @"D8686B"];
    NSInteger index = arc4random() % colors.count;
    return colors[index];
}

#pragma mark - ABCenterDataManagerDelegate

- (void)centerDataManager:(ABCenterDataManager *)manager successRequestCategoryListData:(NSArray *)data
{
    if(data.count)
    {
        [self.listItem removeAllObjects];
        [self.listItem addObjectsFromArray:data];
        
        [self.callBackUtils callBackAction:@selector(dataManagerReloadData:) object1:self];
    }
}

@end
