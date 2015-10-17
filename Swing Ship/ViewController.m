//
//  ViewController.m
//  Swing Ship
//
//  Created by Do Minh Hai on 10/17/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
{
    UIImageView* ship;
    UIImageView* sea1, *sea2;
    AVAudioPlayer* audioPlayer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawShipAndSea];
    [self animateShip];
    [self animateSea];
    [self playSong];
}
-(void) drawShipAndSea
{
    sea1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea1"]];
    sea1.frame = self.view.bounds;
    [self.view addSubview:sea1];
    
    sea2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sea2"]];
    sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:sea2];
    
    ship = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Ship2"]];
    ship.center = CGPointMake(200, 500);
    [self.view addSubview:ship];
}

-(void) animateShip
{
    [UIView animateWithDuration:1 animations:^{
        ship.transform = CGAffineTransformMakeRotation(-0.08);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1
                         animations:^{
                             ship.transform = CGAffineTransformMakeRotation(0.08);
                         } completion:^(BOOL finished) {
                             [self animateShip];
                         }];
    }];}
-(void) animateSea
{
    [UIView animateWithDuration:10
                     animations:^{
                         sea1.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         sea2.frame = self.view.bounds;
                     } completion:^(BOOL finished) {
                         sea1.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         [UIView animateWithDuration:10 animations:^{
                             sea1.frame = self.view.bounds;
                             sea2.frame = CGRectMake(-self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                         } completion:^(BOOL finished) {
                             sea2.frame = CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                             [self animateSea];
                         }];
                         
                     }];
}
- (void) playSong {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Caribe" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
- (void) viewWillDisappear:(BOOL)animated {
    [audioPlayer stop];
}
@end

