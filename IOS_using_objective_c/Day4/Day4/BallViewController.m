//
//  ViewController.m
//  Day4
//
//  Created by Thaowpsta Saiid on 22/04/2026.
//

#import "BallViewController.h"

@interface BallViewController ()

@end

@implementation BallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.ball.layer.cornerRadius = self.ball.bounds.size.width / 2.0;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    [self demoGravity];
}

- (void)demoGravity {
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.ball]];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ball]];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundary:YES];
    
    collisionBehavior.collisionDelegate = self;
    
    [self.animator addBehavior:collisionBehavior];
    
    self.itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ball]];
    self.itemBehavior.elasticity = 0.75;
    [self.animator addBehavior:self.itemBehavior];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
    CGPoint velocity = [self.itemBehavior linearVelocityForItem:item];
    
    if (fabs(velocity.y) < 5.0) {
        self.ball.backgroundColor = [UIColor blueColor];
    }
}

@end
