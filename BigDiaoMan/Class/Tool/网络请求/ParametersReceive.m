//
//  ParametersReceive.m
//  ProductShow
//
//  Created by 何炳煌 on 14/11/2.
//  Copyright (c) 2014年 HandSomeMan. All rights reserved.
//

#import "ParametersReceive.h"

@implementation ParametersReceive
#pragma mark- 保证<null>的时候不会为空
+(NSString*)keep:(NSDictionary*)dic ObjForKey:(NSString*)key{
    
    return [[dic objectForKey:key]isEqual:[NSNull null]]?@"":[NSString stringWithFormat:@"%@",[dic objectForKey:key]];
}
#pragma mark-   ----今日推荐----
+(NSArray*)getTodayRecommend:(NSDictionary*)dic
                      forKey:(NSString*)key{
    
    NSMutableArray *dataArry=[[NSMutableArray alloc]init];
    NSArray *brandlistArry=[dic objectForKey:key];
 
    for (int i=0 ; i<brandlistArry.count; i++) {
        NSDictionary *keepDic=[brandlistArry objectAtIndex:i];
        ParametersList *model=[[ParametersList alloc]init];
        
        model.todayRecommend_date=[ParametersReceive keep:keepDic ObjForKey:@"date"];
        model.todayRecommend_description=[ParametersReceive keep:keepDic ObjForKey:@"description"];
        model.todayRecommend_image_url=[ParametersReceive keep:keepDic ObjForKey:@"image-url"];
        model.todayRecommend_brandId=[ParametersReceive keep:keepDic ObjForKey:@"brand-id"];
        model.todayRecommend_brandName=[ParametersReceive keep:keepDic ObjForKey:@"brand-name"];
        //横向列表
        NSMutableArray *productlistArry=[[NSMutableArray alloc]init];
        NSArray *productlist=[keepDic objectForKey:@"product-list"];
     
        for (int j=0; j<productlist.count; j++) {
             ParametersList *productlistModel=[[ParametersList alloc]init];
            NSDictionary *productlistDic=[productlist objectAtIndex:j];
            productlistModel.todayRecommendList_id=[ParametersReceive keep:productlistDic ObjForKey:@"product-id"];
            productlistModel.todayRecommendList_image=[ParametersReceive keep:productlistDic ObjForKey:@"product-image"];
            productlistModel.todayRecommendList_name=[ParametersReceive keep:productlistDic ObjForKey:@"product-name"];
            productlistModel.todayRecommendList_price=[ParametersReceive keep:productlistDic ObjForKey:@"product-price"];
            productlistModel.todayRecommendList_taobao_url=[ParametersReceive keep:productlistDic ObjForKey:@"taobao-url"];
           // CLog(@"%@", productlistModel.todayRecommendList_name);
            [productlistArry addObject:productlistModel];
        }
        
        model.todayRecommend_product_list=[NSArray arrayWithArray:productlistArry];
        
        [dataArry addObject:model];
    }
    
    
    
    
    return dataArry;

}
#pragma mark-   ----品牌列表----
+(NSArray*)getBrandList:(NSDictionary*)dic forKey:(NSString*)key{
    
    NSMutableArray *dataArry=[[NSMutableArray alloc]init];
    NSArray *brandlistArry=[dic objectForKey:key];
    for (int i=0 ; i<brandlistArry.count; i++) {
        NSDictionary *keepDic=[brandlistArry objectAtIndex:i];
        ParametersList *model=[[ParametersList alloc]init];
        model.brandList_description=[ParametersReceive keep:keepDic ObjForKey:@"brand-description"];
        model.brandList_id=[ParametersReceive keep:keepDic ObjForKey:@"brand-id"];
        model.brandList_name=[ParametersReceive keep:keepDic ObjForKey:@"brand-name"];
        model.brandList_image=[ParametersReceive keep:keepDic ObjForKey:@"brand-image"];
        
        [dataArry addObject:model];
    }
    
    
    
    
    return dataArry;
}

#pragma mark-   ----加载分类----
+(NSArray*)getCategoryList:(NSDictionary*)dic forKey:(NSString*)key{
    NSMutableArray *dataArry=[[NSMutableArray alloc]init];
    NSArray *brandlistArry=[dic objectForKey:key];
    for (int i=0 ; i<brandlistArry.count; i++) {
        NSDictionary *keepDic=[brandlistArry objectAtIndex:i];
        ParametersList *model=[[ParametersList alloc]init];
        model.category_description=[ParametersReceive keep:keepDic ObjForKey:@"category-description"];
        model.category_id=[ParametersReceive keep:keepDic ObjForKey:@"category-id"];
        model.category_name=[ParametersReceive keep:keepDic ObjForKey:@"category-name"];
        model.category_image=[ParametersReceive keep:keepDic ObjForKey:@"category-image"];
        model.category_amount=[ParametersReceive keep:keepDic ObjForKey:@"product-amount"];
        [dataArry addObject:model];
    }
    return dataArry;
}
#pragma mark-   ----通过品牌加载商品----
#pragma mark 商品详情
+(ParametersList*)getFindByBrand:(NSDictionary*)dic{
     ParametersList *model=[[ParametersList alloc]init];
    model.product_description=[ParametersReceive keep:dic ObjForKey:@"brand-description"];
    model.product_id=[ParametersReceive keep:dic ObjForKey:@"brand-id"];
    model.product_image=[ParametersReceive keep:dic ObjForKey:@"brand-image"];
    return model;
}
#pragma mark 商品列表
+(NSArray*)getFindByBrand:(NSDictionary*)dic forKey:(NSString*)key{
    NSMutableArray *dataArry=[[NSMutableArray alloc]init];
    NSArray *brandlistArry=[dic objectForKey:key];
    for (int i=0 ; i<brandlistArry.count; i++) {
        NSDictionary *keepDic=[brandlistArry objectAtIndex:i];
        ParametersList *model=[[ParametersList alloc]init];
        model.productList_id=[ParametersReceive keep:keepDic ObjForKey:@"product-id"];
        model.productList_image=[ParametersReceive keep:keepDic ObjForKey:@"product-image"];
        model.productList_name=[ParametersReceive keep:keepDic ObjForKey:@"product-name"];
         model.productList_price=[ParametersReceive keep:keepDic ObjForKey:@"product-price"];
         model.productList_taobao_url=[ParametersReceive keep:keepDic ObjForKey:@"taobao-url"];
        [dataArry addObject:model];
    }
    return dataArry;
}
//-单品浏览
+(NSArray*)getProductSimple:(NSDictionary*)dic
                     forKey:(NSString*)key{
    NSMutableArray *dataArry=[[NSMutableArray alloc]init];
  
        NSDictionary *keepDic=[dic objectForKey:key];
        ParametersList *model=[[ParametersList alloc]init];
        model.productSimple_description=[ParametersReceive keep:keepDic ObjForKey:@"product-description"];
        model.productSimple_id=[ParametersReceive keep:keepDic ObjForKey:@"product-id"];
        model.productSimple_image=[ParametersReceive keep:keepDic ObjForKey:@"product-image"];
        model.productSimple_name=[ParametersReceive keep:keepDic ObjForKey:@"product-name"];

        model.productSimple_price=[ParametersReceive keep:keepDic ObjForKey:@"product-price"];
        model.productSimple_taobao_url=[ParametersReceive keep:keepDic ObjForKey:@"taobao-url"];
        [dataArry addObject:model];
    
    return dataArry;
}
@end
