//
//  QuestionInfo.h
//  LFY_SuperGuessImage
//
//  Created by IOS.Mac on 17/2/4.
//  Copyright © 2017年 com.elepphant.pingchuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QuestionInfo : NSObject
//<key>answer</key>
//<string>越光宝盒</string>
//<key>icon</key>
//<string>movie_ygbh</string>
//<key>title</key>
//<string>恶搞风格的喜剧大片</string>
//<key>options</key>
//<array>

@property (nonatomic,copy)NSString *answer;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)NSArray *options;

@property (nonatomic, strong, readonly) UIImage *image;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)questionWithDict:(NSDictionary *)dict;
+ (NSArray *)questions;
@end
