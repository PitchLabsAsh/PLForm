//
//  PLViewController.m
//  PLForm
//
//  Created by Ash Thwaites on 11/03/2015.
//  Copyright (c) 2015 Ash Thwaites. All rights reserved.
//

#import "PLViewController.h"
#import "PLForm.h"
#import "PLFormViewController.h"

@interface PLViewController () <PLFormElementDelegate>
{
    PLFormSwitchFieldElement    *switchFormElement;
    PLFormSelectFieldElement    *selectFormElement;
}

@property (weak, nonatomic) IBOutlet PLFormSwitchField  *switchField;
@property (weak, nonatomic) IBOutlet PLFormSelectField  *selectField;

@end

@implementation PLViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    switchFormElement = [PLFormSwitchFieldElement switchFieldElementWithID:0 title:@"Pre populated" value:NO delegate:self];
    [_switchField updateWithElement:switchFormElement];
    
    selectFormElement = [PLFormSelectFieldElement selectElementWithID:1 title:@"Select alignment" values:@[@"Left",@"Center",@"Right"] index:0 insertBlank:NO delegate:self];
    [_selectField updateWithElement:selectFormElement];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[PLFormViewController class]])
    {
        NSInteger alignments[] = {NSTextAlignmentLeft,NSTextAlignmentCenter,NSTextAlignmentRight};
        
        PLFormViewController *bfvc = (PLFormViewController*)segue.destinationViewController;
        bfvc.prePopulate = switchFormElement.value;
        bfvc.alignment = alignments[selectFormElement.index];
    }
}


@end
