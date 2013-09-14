//
//  setGameViewController.m
//  Matchismo
//
//  Created by Adam on 9/13/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import "setGameViewController.h"
#import "SetCardGame.h"

@interface setGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *setsLabel;
@property (strong, nonatomic) SetCardGame *game;

@end

@implementation setGameViewController

- (SetCardGame *)game {
    if (!_game) _game = [[SetCardGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)updateUI:(NSString *)stringForDetails {
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[card displayContents] forState:UIControlStateNormal];
        [cardButton setAttributedTitle:[card displayContents] forState:UIControlStateSelected];
        cardButton.selected = card.isFaceUp;
        if (cardButton.selected) {
            [cardButton setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.7]];
        } else {
            [cardButton setBackgroundColor:[UIColor whiteColor]];
        }
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.0 : 1.0);
        [self.setsLabel setText:[NSString stringWithFormat:@"Sets: %d", self.game.sets]];
        [self.detailsLabel setText:stringForDetails];
    }
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI:nil];
}

- (IBAction)selectCard:(id)sender {
    [self updateUI:[self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]]];
}

- (IBAction)deal:(id)sender {
    self.game = nil;
    [self updateUI:@"New Game!"];
}

- (void)viewDidLoad
{
    [self updateUI:nil];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
