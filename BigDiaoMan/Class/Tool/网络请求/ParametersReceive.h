//
//  ParametersReceive.h
//  ProductShow
//
//  Created by 何炳煌 on 14/11/2.
//  Copyright (c) 2014年 HandSomeMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParametersList.h"
@interface ParametersReceive : NSObject
//------- 方法 -------
//保证不为空
+(NSString*)keep:(NSDictionary*)dic
       ObjForKey:(NSString*)key;

//-------处理数据-------
//-今日推荐
+(NSArray*)getTodayRecommend:(NSDictionary*)dic
                      forKey:(NSString*)key;

//-品牌列表
+(NSArray*)getBrandList:(NSDictionary*)dic
                 forKey:(NSString*)key;
//-加载分类
+(NSArray*)getCategoryList:(NSDictionary*)dic
                    forKey:(NSString*)key;
//-通过品牌加载商品
//商品详情
+(ParametersList*)getFindByBrand:(NSDictionary*)dic;
//商品列表
+(NSArray*)getFindByBrand:(NSDictionary*)dic
                   forKey:(NSString*)key;
//-单品浏览
+(NSArray*)getProductSimple:(NSDictionary*)dic
                     forKey:(NSString*)key;
@end
