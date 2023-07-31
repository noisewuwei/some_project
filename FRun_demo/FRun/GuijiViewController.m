//
//  GuijiViewController.m
//  FRun
//
//  Created by noise on 2016/11/8.
//  Copyright © 2016年 noisecoder. All rights reserved.
//

#import "GuijiViewController.h"
#import "Define.h"
#import "GuiJiCollectionViewCell.h"
#import "PicViewViewController.h"

@interface GuijiViewController (){
    NSMutableArray *picnameArr;
}

@end

@implementation GuijiViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.navigationItem.title = @"轨迹记录";
    [self createBarLeftWithImage:@"Back.png"];
    
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 2;
    layout.minimumLineSpacing = 2;

    
    _collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight) collectionViewLayout:layout];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.showsHorizontalScrollIndicator = NO;
    
    
    [_collectionview registerClass:[GuiJiCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    
    [self.view addSubview:_collectionview];
    
    NSString *pathStr = [NSString stringWithFormat:@"%@/Documents",NSHomeDirectory()];
    
    NSFileManager *fileM = [NSFileManager defaultManager];
    
    NSArray *pathArr = [fileM contentsOfDirectoryAtPath:pathStr error:nil];
    
    picnameArr = [NSMutableArray array];
    
    if (pathArr) {
        for (NSString *picStr in pathArr) {
            if ([[picStr pathExtension] isEqualToString:@"png"]) {
                [picnameArr addObject:picStr];
            }
        }
    }else{
        NSLog(@"hehe");
    }
    
    
    
    NSLog(@"Path Array:%@",picnameArr);
    
    
    // Do any additional setup after loading the view.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return picnameArr.count;
}
//cell 尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat sizeW = (zScreenWidth-6)/3;
    //    CGFloat sizeh = (self.view.bounds.size.height-Crevice)/2;
    
    return CGSizeMake(sizeW, 150);
    
    //      return CGSizeMake(185, 270);
    
    
    
}
//cell 间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {zScreenWidth, 0};
    return size;
}
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = {zScreenWidth, 0};
    return size;
}

//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GuiJiCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    UIImageView *imagev = [[UIImageView alloc]initWithFrame:cell.frame];
    [cell addSubview:imagev];
    NSString *string = picnameArr[indexPath.row];
    NSLog(@"%@",string);
    NSString *Path = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),string];
    // 拿到沙盒路径图片
    UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:Path];
//    cell.backgroundColor = [UIColor whiteColor];
    cell.picImg.image = imgFromUrl;
    
    
    return cell;
//    GuiJiCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
   


}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    PicViewViewController *picVC = [[PicViewViewController alloc]init];
    picVC.imgUrl = picnameArr[indexPath.row];
    [self.navigationController pushViewController:picVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
