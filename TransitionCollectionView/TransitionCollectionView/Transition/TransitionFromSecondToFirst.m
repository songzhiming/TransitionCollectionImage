//
//  TransitionFromSecondToFirst.m
//  TransitionCollectionView
//
//  Created by 宋志明 on 15/12/9.
//  Copyright © 2015年 宋志明. All rights reserved.
//

#import "TransitionFromSecondToFirst.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ImageCollectionViewCell.h"
@implementation TransitionFromSecondToFirst

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    SecondViewController *firstVc =[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    FirstViewController *secondVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *snapShot = [firstVc.iconImageView snapshotViewAfterScreenUpdates:YES];
    snapShot.frame = [containerView convertRect:firstVc.iconImageView.frame fromView:firstVc.view];
    secondVc.view.frame = [transitionContext finalFrameForViewController:secondVc];
    secondVc.view.alpha = 0;
    ImageCollectionViewCell *cell = (ImageCollectionViewCell *)secondVc.selectedCell;
    
    [containerView addSubview:secondVc.view];
    [containerView addSubview:snapShot];
    [UIView animateWithDuration:0.5 animations:^{
        secondVc.view.alpha = 1.0;
        //        snapShot.frame = [containerView convertRect:secondVc.iconImageView.frame fromView:secondVc.view];
        snapShot.frame = [containerView convertRect:cell.iconImageView.frame fromView:cell];
    } completion:^(BOOL finished) {
        secondVc.selectedCell.hidden = NO;
        
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}



@end
