//
//  NodeNoteModel.h
//  BuldingMall
//
//  Created by noise on 16/9/25.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodeNoteModel : NSObject

@property (nonatomic,strong) NSString *created;
@property (nonatomic,strong) NSString *note;
+(instancetype)initNodeNoteWithDict:(NSDictionary *)dict;

@end
