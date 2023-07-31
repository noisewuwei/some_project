//
//  HomeViewController.m
//  BuldingMall
//
//  Created by Jion on 16/9/7.
//  Copyright © 2016年 Youjuke. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductListController.h"
#import "ProductDetailController.h"
#import "CustomerServiceVC.h"
#import "ZLCGuidePageView.h"
#import "YNCollectionViewCell.h"
#import "HotModel.h"
#import "BannerModel.h"
#import "myFootView.h"
#import "myHeadView.h"
#import "mySFooterView.h"
#import "mySHeaderView.h"
#import "OnSaleController.h"
#import "ScrollImage.h"

#define kIndexListUrl @"GetIndexData"//我的主页的接口
@interface HomeViewController ()<UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ScrollImageDelegate>


{
    
    UIScrollView  *scroView;
    
    UIPageControl *imagePageControl;
    
    UICollectionView *collection;
    
    NSMutableArray *_hotArr;
    
    NSMutableArray *baoarr;
    
    NSMutableArray *bannArr;
    
    UIView   *bgView;
    
    NSDictionary *datadic;
    NSString *typelab;
    NSString *content;
    NSString *type;
    NSString *targetname;
    NSString *imge;
    NSString *link;
    NSString *image;
    NSString *name;
    NSString *seckill_price;
    NSString *urlld;
    NSString *str;
    NSString *namelll;
    NSString *str2;
    NSString *namelll2;
    NSString *offline_time;
    
    NSString *offlineimg;
    
    NSMutableArray *linkarr;
    
    NSMutableArray *net_price;
    
}

@end
//yn 一行 coding
static NSString *cellIdentifier = @"cell";
@implementation HomeViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIImageView *img = [self.navigationController.navigationBar viewWithTag:200];
    img.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   UIImageView *img = [self.navigationController.navigationBar viewWithTag:200];
    img.hidden = NO;
}

-(void)setNavigation{
    self.navigationItem.title = @"建材特卖";
    // Do any additional setup after loading the view.
    UIImageView *navImg = [[UIImageView alloc] init];
    navImg.tag = 200;
    navImg.frame = CGRectMake(10, 0, 100, 44);
    navImg.contentMode = UIViewContentModeCenter;
    navImg.image = [UIImage imageNamed:@"btn_logo2.png"];
    [self.navigationController.navigationBar addSubview:navImg];
    [self createBarRightWithImage:@"btn_kefu00.png"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
//    [self buildWebView];

    
    
    [self createcoll]; //yn collection coding
    
    //yn coding
    [self loadDataIndexFormServer:kIndexListUrl params:@{}];
    
    
    
    
}
//yn setuprefresh coding
-(void)setuprefresh
{
     // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    collection.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerreshing)];
    
}
-(void)headerreshing
{
    [self loadDataIndexFormServer:kIndexListUrl params:@{}];
}
#pragma mark -- Action
-(void)showRight:(UIButton *)sender{
    CustomerServiceVC *customerService = [[CustomerServiceVC alloc] init];
    NSString *serviceUrl = @"http://m.youjuke.com/index/kf_html";
    customerService.webPath = @"/im/gateway";
    customerService.webRequestURL = serviceUrl;
    
    [self.navigationController pushViewController:customerService animated:YES];
}

//#pragma mark --UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    
//    NSString *path = request.URL.path;
//    NSString * requestStr =[request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSString *body  =[[ NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
//    /*
//     轮播： (建材免单)/jchd.html (一元超值)/redemption/index (一元夺宝)/snatch/index
//     爆款秒杀：/onsale/item
//     精选特卖：/onsale/oldlist
//     一元夺宝：/snatch/index
//     一元超值列表：/redemption/index
//     一元超值购：/redemption/detail
//     
//     下场秒杀：/onsale/item
//     今日秒杀，即将开抢，马上抢：/onsale/item
//     
//     
//     更多商品是列表：/onsale/oldlist
//     立即购买：/onsale/old_item 有参数id
//     参加夺宝：/snatch/snatch_item 有参数id
//     客服：/im/gateway
//     服务协议：/onsale/fuwu
//     */
//    if ([path isEqualToString:@"/onsale/item"]||[path isEqualToString:@"/onsale/old_item"]) {
//        ProductDetailController *productDetail = [[ProductDetailController alloc] init];
//        productDetail.webPath = path;
//        
//        productDetail.webRequestURL = requestStr;
//        if (body) {
//            productDetail.params = body;
//        }
//        [self.navigationController pushViewController:productDetail animated:YES];
//        return NO;
//    }
//    else if ([path isEqualToString:@"/onsale/oldlist"]||[path isEqualToString:@"/redemption/index"]||[path isEqualToString:@"/snatch/index"]){
//        ProductListController *productList = [[ProductListController alloc] init];
//        
//        productList.webPath = path;
//        productList.webRequestURL = requestStr;
//        if ([path isEqualToString:@"/onsale/oldlist"]) {
//            productList.title = @"精选特卖";
//        }else if ([path isEqualToString:@"/redemption/index"]){
//            productList.title = @"一元超值购";
//        }
//        [self.navigationController pushViewController:productList animated:YES];
//        
//        return NO;
//    }else if ([path isEqualToString:@"/onsale/fuwu"]){
//        CustomerServiceVC *customerService = [[CustomerServiceVC alloc] init];
//        customerService.webPath = path;
//        customerService.webRequestURL = requestStr;
//        
//        [self.navigationController pushViewController:customerService animated:YES];
//        return NO;
//    }
//
//    else if ([path isEqualToString:@"/jchd.html"]){
//        [self.tabBarController setSelectedIndex:1];
//        return NO;
//    }
//    
//    return YES;
//}


//yn coding
-(void)loadDataIndexFormServer:(NSString *)url params:(NSDictionary *)param
{
    
    //第一个待付款按钮触发的列表请求数据
    [HTTPRequest postWithURL:url params:param ProgressHUD:self.Hud controller:self response:^(id json)
     {
         //10月18号 添加刷新代码
         /**
          *  让下拉刷新头部控件停止刷新状态
          */
         [collection.header endRefreshing];
         
         datadic = (NSDictionary *)json;
         
          NSLog(@"我的主页%@",datadic);
         
         
         NSMutableArray *bannerarr = [datadic objectForKey:@"banner_images"];//轮播图数组
         
         bannArr = [[NSMutableArray alloc]init];//轮播图数组
         linkarr = [[NSMutableArray alloc]init];
         
         
         [self getdateserver];
         
         [self arrangeBanneListOrder:bannerarr];//轮播图数据
         
         
         NSMutableArray *dataArr = [datadic objectForKey:@"combo_goods"];//建材热销榜单
         
        _hotArr = [[NSMutableArray alloc]init];
         
        [self arrangeDataListOrder:dataArr];//建材热销榜单 商品数据
         
         
         
         NSMutableArray *paoarr = [datadic objectForKey:@"hot_goods"];//爆款预告
         
          baoarr = [[NSMutableArray alloc]init];
         
         [self arrangebaoDataListOrder:paoarr];//爆款预告 商品数据
         
         
//        [collection reloadData];

         
         
         
     } error400Code:^(id failure)
     {
         [collection.header endRefreshing];
         
     }];
    
    
    
}

-(void)getdateserver
{
    //红榜或者绿榜解析
    NSDictionary *revice_report = [datadic objectForKey:@"service_report"];
    typelab = [revice_report objectForKey:@"type"];
    NSLog(@"typelab%@",typelab);
    content = [revice_report objectForKey:@"content"];
    NSLog(@"content%@",content);
    
    //offliane_time
    offline_time = [datadic objectForKey:@"offline_time"];
    NSLog(@"offline_time%@",offline_time);
    
    //一元超值购
    NSDictionary *redemption_ad = [datadic objectForKey:@"redemption_ad"];
    type = [redemption_ad objectForKey:@"type"];//1
    NSLog(@"type%@",type);
    
    targetname = [redemption_ad objectForKey:@"target"];//一元超值购
    NSLog(@"targetname%@",targetname);
    
    imge = [redemption_ad objectForKey:@"img"];//图片
    NSLog(@"img%@",imge);
    
    link = [redemption_ad objectForKey:@"link"];//指向的链接
    NSLog(@"link%@",link);
    
    //今日亏本秒杀解析
    
    NSDictionary *cur_seckill = [datadic objectForKey:@"cur_seckill"];
    image = [cur_seckill objectForKey:@"image"];
    NSLog(@"image%@",image);
    
    name = [cur_seckill objectForKey:@"name"];//秒杀商品标题
    NSLog(@"name%@",name);
    
    seckill_price = [cur_seckill objectForKey:@"seckill_price"];
    NSLog(@"price%@",seckill_price);
    
    urlld = [cur_seckill objectForKey:@"url"];
    NSLog(@"url%@",urlld);
    
    net_price = [cur_seckill objectForKey:@"net_price"];
    NSLog(@"111111");
    NSLog(@"%lu",(unsigned long)net_price.count);
    NSLog(@"22222");
    
    if (net_price.count == 2) {
        str = [net_price[0] valueForKey:@"bj"];
        NSLog(@"%@",str);
        
        namelll = [net_price[0] valueForKey:@"name"];
        NSLog(@"namelll%@",namelll);
        
        str2 = [net_price[1] valueForKey:@"bj"];
        NSLog(@"%@",str);
        
        namelll2 = [net_price[1] valueForKey:@"name"];
        NSLog(@"namelll%@",namelll);
    }else if(net_price.count == 1){
        str = [net_price[0] valueForKey:@"bj"];
        NSLog(@"start");
        NSLog(@"%@",str);
        
        namelll = [net_price[0] valueForKey:@"name"];
        NSLog(@"namelll%@",namelll);
    }

    
    NSDictionary *offline_ad = [datadic objectForKey:@"offline_ad"];
    offlineimg = [offline_ad objectForKey:@"img"];
    NSLog(@"offlineimg%@",offlineimg);
    
    
    
}
//轮播图的数组
-(void)arrangeBanneListOrder:(NSArray *)resultArray
{
    if (resultArray.count == 0)
    {
        [bannArr removeAllObjects];
        
    }
    else
    {
        if (bgView)
        {
            [bgView removeFromSuperview];
            bgView = nil;
            
        }
        
        for (NSDictionary *dictt in resultArray)
        {
            BannerModel *model = [BannerModel initBannerListWithDict:dictt];
            
            [bannArr addObject:model.img];
            [linkarr addObject:model];
            
        }
        
        NSLog(@"bannArr%@",bannArr);
        

    }
    
    [collection reloadData];
    
}

//商品数据
-(void)arrangeDataListOrder:(NSArray *)resultArray
{
    if (resultArray.count == 0)
    {
        [_hotArr removeAllObjects];
        //        [self nilView];
        
        
    }
    else
    {
        if (bgView)
        {
            [bgView removeFromSuperview];
            bgView = nil;
            
        }
        
        
        for (NSDictionary *dict in resultArray)
        {
            
            HotModel *model = [HotModel initHotListWithDict:dict];
            
            [_hotArr addObject:model];
            
        }
        
        NSLog(@"_hotArr%@",_hotArr);
        
        
    }
    
    
    [collection reloadData];
    
}


// 爆款预告 商品数据
-(void)arrangebaoDataListOrder:(NSArray *)resultArray
{
    if (resultArray.count == 0)
    {
        [baoarr removeAllObjects];
        //        [self nilView];
        
        
    }
    else
    {
        if (bgView)
        {
            [bgView removeFromSuperview];
            bgView = nil;
            
        }
        
        
        for (NSDictionary *dict in resultArray)
        {
            
            HotModel *model = [HotModel initHotListWithDict:dict];
            
            [baoarr addObject:model];
            
        }
        
        NSLog(@"baoArr%@",baoarr);
        
        
    }
    
    
    [collection reloadData];

}


//yn collection coding
-(void)createcoll
{
    //    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc]init];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //    layout.itemSize = CGSizeMake(185, 270);
    //    layout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 1);//上 左 下 右
    //    layout.minimumLineSpacing = 1;
    
    collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, zScreenWidth, zScreenHeight-64-60) collectionViewLayout:layout];
    collection.backgroundColor = [UIColor colorHexString:@"f0f0f0"];
    
    collection.delegate = self;
    
    collection.dataSource = self;
    
    
     [collection registerNib:[UINib nibWithNibName:@"YNCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
    
    
    [collection registerClass:[myHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView"];
    
    [collection registerClass:[myFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootView"];
    
    [collection registerClass:[mySHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sHeadView"];
    
    [collection registerClass:[mySFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sFootView"];
    
   
    
    
    [self.view addSubview:collection];
    
    [self setuprefresh];
    
    
}


//返回的行数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {

        return _hotArr.count;
    }
    else
    {

        return baoarr.count;
        
    }
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YNCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    if (indexPath.section == 0)
    {
        
        HotModel *hotmodel = [_hotArr objectAtIndex:indexPath.row];
        
        cell.nameLab.text = hotmodel.name;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:YouJuKeImageUrl(hotmodel.image)]];
        cell.moneyLab.text = [NSString stringWithFormat:@"￥%@",hotmodel.sale_price];
        cell.hidView.hidden = NO;
        cell.pilab.text = [NSString stringWithFormat:@"%@人已购买",hotmodel.total_sales];
        
       
    }
    else if(indexPath.section == 1)
    {

        HotModel *hotmodel = [baoarr objectAtIndex:indexPath.row];
        cell.nameLab.text = hotmodel.name;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:YouJuKeImageUrl(hotmodel.image)]];
        cell.moneyLab.text = [NSString stringWithFormat:@"￥%@",hotmodel.seckill_price];
        cell.hidView.hidden = YES;

    }
    
   
   return cell;
    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        ProductDetailController *detail = [[ProductDetailController alloc]init];
        
         HotModel *model = [_hotArr objectAtIndex:indexPath.row];
        
         detail.webRequestURL = model.url;
        NSURL *webURL = [NSURL URLWithString:model.url];
        detail.webPath = webURL.path;
        detail.title = @"商品详细";
        
        [self.navigationController pushViewController:detail animated:YES];
        
        
    }
    else
    {
        OnSaleController *onsale = [[OnSaleController alloc]init];
        
        [self.navigationController pushViewController:onsale animated:YES];
        
    }
    
    
    

    
}
#pragma mark --CollectionViewDelegate
#define Crevice   2

//
//定义每个cell 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}
//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return Crevice;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}


-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {self.view.bounds.size.width, 717};
        return size;
    }
    else
    {
        CGSize size = {self.view.bounds.size.width, 230};
        return size;
    }
}


-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {self.view.bounds.size.width, 10};
        return size;
    }
    else
    {
        CGSize size = {self.view.bounds.size.width, 200};
        return size;
    }
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    NSLog(@"kind = %@", kind);
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            myHeadView *headerV = (myHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView" forIndexPath:indexPath];
            
            ScrollImage *scrl = [[ScrollImage alloc] initWithCurrentController:self
                                                                     urlString:bannArr
                                                                     viewFrame:CGRectMake(0,0, self.view.bounds.size.width, 150)
                                                              placeholderImage:[UIImage imageNamed:@""]];
            scrl.delegate = self;
            
            
            
            [headerV.scrollview addSubview:scrl.view];
            if ([typelab isEqualToString:@"红榜"])
            {
                headerV.viewc.backgroundColor = [UIColor colorHexString:@"dc0200"];
                headerV.labelc.text = @"红榜";
                
            }
            else
            {
                headerV.viewc.backgroundColor = [UIColor colorHexString:@"333333"];
                headerV.labelc.text = @"黑榜";

            }
            
            headerV.labelbb.text = [NSString stringWithFormat:@"       %@",content];
            headerV.timeLabel.text =  offline_time;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL * url = [NSURL URLWithString:YouJuKeImageUrl(imge)];
                NSData * data = [[NSData alloc]initWithContentsOfURL:url];
                UIImage *testimage = [[UIImage alloc]initWithData:data];
                if (data != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [headerV.view3 setImage:testimage forState:UIControlStateNormal];
                    });   
                }   
            });
            
            [headerV.view3 addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL * url = [NSURL URLWithString:YouJuKeImageUrl(image)];
                NSData * data = [[NSData alloc]initWithContentsOfURL:url];
                UIImage *testimage = [[UIImage alloc]initWithData:data];
                if (data != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [headerV.imagems setImage:testimage forState:UIControlStateNormal];
                    });
                }
            });
            
            [headerV.imagems addTarget:self action:@selector(bkclick) forControlEvents:UIControlEventTouchUpInside];

            headerV.money.text = seckill_price;
            
            headerV.labelms.text = name;
            
            if (net_price.count == 1) {

                headerV.tm.text = [NSString stringWithFormat:@"%@:¥%@",namelll,str];
                
                headerV.jd.hidden = YES;
                
            }else if(net_price.count == 2){
                headerV.tm.text = [NSString stringWithFormat:@"%@:¥%@",namelll,str];
                
                headerV.jd.text = [NSString stringWithFormat:@"%@:¥%@",namelll2,str2];
            }
            
            
            [headerV.bkbtn addTarget:self action:@selector(bkclick) forControlEvents:UIControlEventTouchUpInside];
            
            [headerV.ljqgbtn addTarget:self action:@selector(bkclick) forControlEvents:UIControlEventTouchUpInside];
            
            [headerV.jxbtn addTarget:self action:@selector(jxclick) forControlEvents:UIControlEventTouchUpInside];
            
            [headerV.xxbtn addTarget:self action:@selector(ckgdbk) forControlEvents:UIControlEventTouchUpInside];
            
            reusableview = headerV;
        }else if (indexPath.section == 1){
            mySHeaderView *headerV = (mySHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sHeadView" forIndexPath:indexPath];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSURL * url = [NSURL URLWithString:YouJuKeImageUrl(offlineimg)];
                NSData * data = [[NSData alloc]initWithContentsOfURL:url];
                UIImage *testimage = [[UIImage alloc]initWithData:data];
                if (data != nil) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [headerV.bgImg setImage:testimage forState:UIControlStateNormal];
                    });
                }
            });

            [headerV.bgImg addTarget:self action:@selector(ckgdbk) forControlEvents:UIControlEventTouchUpInside];
            reusableview = headerV;
        }
    }else if(kind == UICollectionElementKindSectionFooter){
        if (indexPath.section == 0) {
            myFootView *footV = (myFootView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootView" forIndexPath:indexPath];
            reusableview = footV;
        }else if (indexPath.section == 1){
            mySFooterView *footV = (mySFooterView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sFootView" forIndexPath:indexPath];
            [footV.button addTarget:self action:@selector(ckgdbk) forControlEvents:UIControlEventTouchUpInside];
            reusableview = footV;
        }
        
    }
    
    return reusableview;
    
}

- (void)scrollImage:(ScrollImage *)scrollImage clickedAtIndex:(NSInteger)index
{
    NSLog(@"click:%ld",(long)index);
    
    if (index == 3002)
    {
        
        ProductDetailController *detail = [[ProductDetailController alloc]init];
        detail.webRequestURL = urlld;
        detail.title = @"今日秒杀";
        detail.webPath = @"/onsale/item";
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if(index == 3003)
    {
        NSLog(@"第三张 跳转到线下特卖的界面");
        BannerModel *model = linkarr[index-3001];
        if (![model.type isEqualToString:@"3"])
        {
            OnSaleController *onsale = [[OnSaleController alloc]init];
            [self.navigationController pushViewController:onsale animated:YES];
        }
        
    }else{
        
        BannerModel *model = linkarr[0];
        
        if (![model.type isEqualToString:@"3"]) {
            ProductListController *product = [[ProductListController alloc]init];
            product.webRequestURL = model.link;//后台返回的轮播数组里面的第一个链接给传到下一个界面
            NSLog(@"%@",model.link);
            product.title = model.title;//后台返回的轮播数组里面的第一个title给传到下一个界面
            [self.navigationController pushViewController:product animated:YES];
        }
    }
    
}


-(void)jump
{
    [[BaiduMobStat defaultStat] logEvent:@"one_buy" eventLabel:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    
    ProductListController *product = [[ProductListController alloc]init];
    product.webRequestURL = link;
    product.title = @"一元超值购";
    [self.navigationController pushViewController:product animated:YES];
}

- (void)bkclick{
    ProductDetailController *detail = [[ProductDetailController alloc]init];
    detail.webRequestURL = urlld;
    detail.title = @"今日秒杀";
    detail.webPath = @"/onsale/item";
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)jxclick{
    ProductListController *product = [[ProductListController alloc]init];
    product.webRequestURL = kJingXuanWebUrl;
    product.title = @"精选特卖";
    [self.navigationController pushViewController:product animated:YES];
}

- (void)ckgdbk{//c查看更多爆款
    OnSaleController *onsale = [[OnSaleController alloc]init];
    [self.navigationController pushViewController:onsale animated:YES];
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return Crevice;
}

//通过协议方法设置单元格尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat sizeW = (zScreenWidth-Crevice)/2;
    //    CGFloat sizeh = (self.view.bounds.size.height-Crevice)/2;
    
    return CGSizeMake(sizeW, 270);
    
    //      return CGSizeMake(185, 270);
    
    
    
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
