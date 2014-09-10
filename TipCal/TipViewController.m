//
//  TipViewController.m
//  TipCal
//
//  Created by Palanisamy Kozhanthaiappan on 9/6/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
@property (weak, nonatomic) IBOutlet UISlider *sliderControl;
@property (weak, nonatomic) IBOutlet UILabel *splitLabel;

@property (weak, nonatomic) IBOutlet UILabel *personLabel;

@property (weak, nonatomic) IBOutlet UILabel *personAmountLabel;

- (IBAction)splitSlidder:(id)sender;
- (IBAction)onTab:(id)sender;
- (void)updateTipCaulator;
- (void)updateView;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Cal";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self.billTextField becomeFirstResponder];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)splitSlidder:(id)sender {
    int sliderValue;
    sliderValue = lround(self.sliderControl.value);
    [self.sliderControl setValue:sliderValue animated:YES];
    [self updateTipCaulator];
}



- (IBAction)onTab:(id)sender {
    [self.view endEditing:YES];
    [self updateTipCaulator];
}

- (void) updateTipCaulator {
    float billAmount = [self.billTextField.text floatValue];
    
    int splitBy = self.sliderControl.value;
    
    
    NSArray *tipValues = @[@(0.1),@(0.15),@(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalAmount = tipAmount + billAmount;
    float personAmount = (totalAmount/splitBy);
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];

    if (splitBy == 0) {
        self.personAmountLabel.text = @"";
        self.personLabel.text = @"";
        self.splitLabel.text = @"Slid to split bill";
        
    } else {
        self.personLabel.text = @"Person";
        self.personAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", personAmount];
        self.splitLabel.text = [NSString stringWithFormat:@"%d people", splitBy];
    }
    
}

- (void) onSettingsButton {
    
     [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    [self updateView];

    
}

- (void) updateView {
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int colorIndex = [prefs integerForKey:@"colorIndex"];
    int tipIndex = [prefs integerForKey:@"tipIndex"];
    NSLog(@"color=%d", colorIndex);
    NSLog(@"tip=%d", tipIndex);
    
    NSArray *colorArray = [[NSArray alloc] initWithObjects:[UIColor colorWithRed:1 green:0.176 blue:0.333 alpha:1],[UIColor colorWithRed:0.298 green:0.851 blue:0.392 alpha:1], [UIColor colorWithRed:0 green:0.478 blue:1 alpha:1], nil];
    
    self.totalLabel.textColor = colorArray[colorIndex];
    self.tipControl.tintColor = colorArray[colorIndex];
    self.tipControl.selectedSegmentIndex = tipIndex;
}


@end
