//
//  GuijiViewController.h
//  FRun
//
//  Created by noise on 2016/11/8.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "BaseViewController.h"

@interface GuijiViewController : BaseViewController <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionview;

@end
