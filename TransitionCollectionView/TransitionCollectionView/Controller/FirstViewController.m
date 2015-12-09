//
//  FirstViewController.m
//  TransitionCollectionView
//
//  Created by 宋志明 on 15/12/8.
//  Copyright © 2015年 宋志明. All rights reserved.
//
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#import "FirstViewController.h"
#import "TransitionFromFirstToSecond.h"
#import "SecondViewController.h"
@interface FirstViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (strong,nonatomic) NSMutableArray *dataArray;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionview registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
    UICollectionViewFlowLayout *categoryFlowLayout = (UICollectionViewFlowLayout *)self.collectionview.collectionViewLayout;
    categoryFlowLayout.itemSize = CGSizeMake(kScreenWidth/2 - 10, 100);
    categoryFlowLayout.minimumInteritemSpacing = 10 ;
    categoryFlowLayout.minimumLineSpacing = 10 ;
    self.dataArray = [[NSMutableArray alloc]initWithObjects:@{@"content":@"111",@"image":@"thing01"},
                      @{@"content":@"222",@"image":@"thing02"},
                      @{@"content":@"333",@"image":@"thing03"},
                      @{@"content":@"444",@"image":@"thing04"},
                      @{@"content":@"555",@"image":@"thing05"},
                      @{@"content":@"222",@"image":@"thing02"},
                      @{@"content":@"333",@"image":@"thing03"},
                      @{@"content":@"444",@"image":@"thing04"},
                      @{@"content":@"222",@"image":@"thing02"},
                      @{@"content":@"333",@"image":@"thing03"},
                      @{@"content":@"444",@"image":@"thing04"},
                      @{@"content":@"555",@"image":@"thing05"},
                      @{@"content":@"222",@"image":@"thing02"},
                      @{@"content":@"333",@"image":@"thing03"},nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set outself as the navigation controller's delegate so we're asked for a transitioning object
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLSecondViewController
    if (fromVC == self && [toVC isKindOfClass:[SecondViewController class]]) {
        return [[TransitionFromFirstToSecond alloc] init];
    }else {
        return nil;
    }
}


#pragma mark - Collection View Data Source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell =(ImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    cell.iconImageView.image = [UIImage imageNamed:[self.dataArray objectAtIndex:indexPath.row][@"image"]];
    cell.describeLabel.text = [self.dataArray objectAtIndex:indexPath.row][@"content"];
    return cell;
};

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCell = (ImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    SecondViewController *vc = [[SecondViewController alloc]init];
    vc.content = [self.dataArray objectAtIndex:indexPath.row][@"content"];
    vc.imageName = [self.dataArray objectAtIndex:indexPath.row][@"image"];
    [self.navigationController pushViewController:vc animated:YES];
}









@end
