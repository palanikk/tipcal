//
//  SettingsViewController.m
//  TipCal
//
//  Created by Palanisamy Kozhanthaiappan on 9/7/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
-(void) updateView;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateView];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onTipSelect:(id)sender {
    [self setPrefs];
    [self updateView];
}
- (IBAction)onColorSelect:(id)sender {
    [self setPrefs];
    [self updateView];
}

- (void) updateView
{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int colorIndex = [prefs integerForKey:@"colorIndex"];
    int tipIndex = [prefs integerForKey:@"tipIndex"];
    
    self.colorControl.selectedSegmentIndex = colorIndex;
    NSArray *colorArray = [[NSArray alloc] initWithObjects:[UIColor colorWithRed:1 green:0.176 blue:0.333 alpha:1],[UIColor colorWithRed:0.298 green:0.851 blue:0.392 alpha:1], [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1], nil];
    
    self.colorControl.tintColor = colorArray[colorIndex];
    self.tipControl.selectedSegmentIndex = tipIndex;
    self.tipControl.tintColor = colorArray[colorIndex];
}

- (void) setPrefs {
    int colorIndex = self.colorControl.selectedSegmentIndex;
    int tipIndex = self.tipControl.selectedSegmentIndex;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:colorIndex forKey:@"colorIndex"];
    [prefs setInteger:tipIndex forKey:@"tipIndex"];
    [prefs synchronize];
}

@end
