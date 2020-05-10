//
//  ViewController.m
//  InteractiveAndInterruptible
//
//  Created by Qiqiuzhe on 2020/1/16.
//  Copyright © 2020 ToolMaker. All rights reserved.
//

#import "YAViewController.h"

@interface YAViewController () {
    UIViewPropertyAnimator *_ani;
    UIViewPropertyAnimator *_cornerAni;
    UIView * _sprite;
    BOOL _poped;
}

@end

@implementation YAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(-250, 100, 300, 400)];
    v.backgroundColor = [UIColor redColor];
    v.clipsToBounds = true;
    if (@available(iOS 11.0, *)) {
        v.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:v];
    _sprite = v;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [v addGestureRecognizer:pan];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            _ani = [[UIViewPropertyAnimator alloc] initWithDuration:1 curve:UIViewAnimationCurveLinear animations:^{
                self->_sprite.frame = CGRectOffset(self->_sprite.frame, self->_poped? -230:230, 0);
            }];
            [_ani pauseAnimation];
            
            _cornerAni = [[UIViewPropertyAnimator alloc] initWithDuration:1 curve:UIViewAnimationCurveLinear animations:^{
                self->_sprite.layer.cornerRadius = 12;
            }];
            [_cornerAni pauseAnimation];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint translation = [sender translationInView:_sprite];
            _ani.fractionComplete = translation.x*(_poped?-1:1)/230;
            _cornerAni.fractionComplete = translation.x*(_poped?-1:1)/230;
        }
            break;
        case UIGestureRecognizerStateEnded: {
            BOOL isCancelled = [self isGestureCancelled:sender];
            [self continerInteractiveTransition:isCancelled];
        }
            break;
        case UIGestureRecognizerStatePossible:
            
            break;
        case UIGestureRecognizerStateCancelled:
            [self continerInteractiveTransition:true];
            break;
        case UIGestureRecognizerStateFailed:
            
            break;
    }
}

//MARK: animations
/**    // Continues or reverse transition on pan .ended
func continueInteractiveTransition(cancel: Bool) {
    if cancel {
        reverseRunningAnimations()
    }
    
    let timing = UICubicTimingParameters(animationCurve: .easeOut)
    for animator in runningAnimators {
        animator.continueAnimation(withTimingParameters: timing, durationFactor: 0)
    }
}*/
- (void)continerInteractiveTransition:(BOOL)cancel {
    if (cancel) {
        _ani.reversed = true;
        _cornerAni.reversed = true;
    } else {
        _poped = !_poped;
    }
    UICubicTimingParameters *timing = [[UICubicTimingParameters alloc] initWithAnimationCurve:UIViewAnimationCurveEaseOut];
    [_ani continueAnimationWithTimingParameters:timing durationFactor:0];
    [_cornerAni continueAnimationWithTimingParameters:timing durationFactor:0];
}

//MARK: private
/**    private func isGestureCancelled(_ recognizer: UIPanGestureRecognizer) -> Bool {
    let isCancelled: Bool
    
    let velocityY = recognizer.velocity(in: view).y
    if velocityY != 0 {
        let isPanningDown = velocityY > 0
        isCancelled = (state == .expanded && isPanningDown) ||
            (state == .collapsed && !isPanningDown)
    }
    else {
        isCancelled = false
    }
    
    return isCancelled
}*/

- (BOOL)isGestureCancelled:(UIPanGestureRecognizer *)recognizer {
    BOOL cancelled = false;
    CGFloat velocityX = [recognizer velocityInView:recognizer.view].x;
    if (velocityX != 0) {
        cancelled = !((_poped && velocityX < 0) || (!_poped && velocityX > 0));
    }
    return cancelled;
}

@end
