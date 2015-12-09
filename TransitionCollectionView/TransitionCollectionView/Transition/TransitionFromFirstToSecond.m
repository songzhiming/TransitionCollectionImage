//
//  TransitionFromFirstToSecond.m
//  TransitionCollectionView
//
//  Created by 宋志明 on 15/12/9.
//  Copyright © 2015年 宋志明. All rights reserved.
//


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "TransitionFromFirstToSecond.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ImageCollectionViewCell.h"

@implementation TransitionFromFirstToSecond



- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    FirstViewController *firstVc =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *secondVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    ImageCollectionViewCell *cell = firstVc.selectedCell;
    UIView *snapShot = [cell.iconImageView snapshotViewAfterScreenUpdates:YES];
    snapShot.frame = [containerView convertRect:cell.iconImageView.frame fromView:cell];
    secondVc.view.frame = [transitionContext finalFrameForViewController:secondVc];
    secondVc.view.alpha = 0;
    secondVc.iconImageView.hidden = YES;
    [containerView addSubview:secondVc.view];
    [containerView addSubview:snapShot];
    [UIView animateWithDuration:0.5 animations:^{
        secondVc.view.alpha = 1.0;
//        snapShot.frame = [containerView convertRect:secondVc.iconImageView.frame fromView:secondVc.view];
        snapShot.frame = CGRectMake(kScreenWidth/2 - 100, 100, 200, 200);
    } completion:^(BOOL finished) {
        secondVc.iconImageView.hidden = NO;
        cell.hidden = NO;
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
