//
//  ParametersList.h
//  ProductShow
//
//  Created by 何炳煌 on 14/11/2.
//  Copyright (c) 2014年 HandSomeMan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParametersList : NSObject
//今日推荐
@property(strong,nonatomic)NSString*todayRecommend_date;
@property(strong,nonatomic)NSString*todayRecommend_description;
@property(strong,nonatomic)NSString*todayRecommend_image_url;
@property(strong,nonatomic)NSString*todayRecommend_brandId;
@property(strong,nonatomic)NSString*todayRecommend_brandName;
@property(strong,nonatomic)NSArray *todayRecommend_product_list;
@property(strong,nonatomic)NSString*todayRecommendList_id;
@property(strong,nonatomic)NSString*todayRecommendList_image;
@property(strong,nonatomic)NSString*todayRecommendList_name;
@property(strong,nonatomic)NSString*todayRecommendList_price;
@property(strong,nonatomic)NSString*todayRecommendList_taobao_url;
//品牌列表
@property(strong,nonatomic)NSString*brandList_description;
@property(strong,nonatomic)NSString*brandList_id;
@property(strong,nonatomic)NSString*brandList_image;
@property(strong,nonatomic)NSString*brandList_name;

//加载分类
@property(strong,nonatomic)NSString*category_description;
@property(strong,nonatomic)NSString*category_id;
@property(strong,nonatomic)NSString*category_name;
@property(strong,nonatomic)NSString*category_image;
@property(strong,nonatomic)NSString*category_amount;
//通过品牌加载商品
@property(strong,nonatomic)NSString*product_description;
@property(strong,nonatomic)NSString*product_id;
@property(strong,nonatomic)NSString*product_image;

@property(strong,nonatomic)NSString*productList_id;
@property(strong,nonatomic)NSString*productList_image;
@property(strong,nonatomic)NSString*productList_name;
@property(strong,nonatomic)NSString*productList_price;
@property(strong,nonatomic)NSString*productList_taobao_url;

//加载单品
@property(strong,nonatomic)NSString*productSimple_description;
@property(strong,nonatomic)NSString*productSimple_id;
@property(strong,nonatomic)NSString*productSimple_image;
@property(strong,nonatomic)NSString*productSimple_name;
@property(strong,nonatomic)NSString*productSimple_price;
@property(strong,nonatomic)NSString*productSimple_taobao_url;
@end
