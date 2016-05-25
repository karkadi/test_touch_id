//
//  ViewController.m
//  test_touch_id
//
//  Created by Arkadiy KAZAZYAN on 25/05/16.
//  Copyright © 2016 Arkadiy KAZAZYAN. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIButton* button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)authenicateButtonTapped:(id)sender {
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Are you the device owner?"
                          reply:^(BOOL success, NSError *error) {
                              
                              if (error) {
                                  [self presentAlertWithTitle:@"Error" message:@"There was a problem verifying your identity."];
                              }
                              
                              if (success) {
                                  [self presentAlertWithTitle:@"Success" message:@"You are the device owner!"];
                                  
                              } else {
                                  [self presentAlertWithTitle:@"Error" message:@"You are not the device owner."];
                                  
                              }
                              
                          }];
        
    } else {
        
        [self presentAlertWithTitle:@"Error" message:@"Your device cannot authenticate using TouchID."];
        
        
    }
}

- (void)presentAlertWithTitle:(NSString*)title  message:(NSString*)message{
    dispatch_async (dispatch_get_main_queue(), ^{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title
                                                                                  message:message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* destroyAction = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action) {
                                                                 // do destructive stuff here
                                                             }];
        
        // note: you can control the order buttons are shown, unlike UIActionSheet
        [alertController addAction:destroyAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

@end
