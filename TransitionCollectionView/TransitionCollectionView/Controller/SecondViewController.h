//
//  SecondViewController.h
//  TransitionCollectionView
//
//  Created by 宋志明 on 15/12/8.
//  Copyright © 2015年 宋志明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *imageName;

@end
