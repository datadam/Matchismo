//
//  cardGameViewController.m
//  Matchismo
//
//  Created by Adam on 5/7/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import "cardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS6.1.sdk/System/Library/Frameworks/QuartzCore.framework/Headers/CALayer.h"

@interface cardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (strong, nonatomic) UIImage *cardBack;
@property (strong, nonatomic) UIImage *cardFront;
@end

@implementation cardGameViewController

- (void)setup {
    self.cardBack = [UIImage imageNamed:@"cardback.png"];
    self.cardFront = [[UIImage alloc] init];
    
    for (UIButton *cardButton in self.cardButtons) {
        [cardButton setImage:self.cardBack forState:UIControlStateNormal];
        [cardButton setImage:self.cardFront forState:UIControlStateSelected];
        [cardButton setImage:self.cardFront forState:UIControlStateSelected|UIControlStateDisabled];
    }
    
}

- (void)setOutlineForButton:(UIButton *)button {
    [button.layer setBorderWidth:1.0];
    [button.layer setCornerRadius:2.5];
    [button.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc]
                         initWithCardCount:[self.cardButtons count]
                         usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
} 

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI:nil];
}

- (void)updateUI:(NSString *)stringForDetails {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.5 : 1.0);
        [self setOutlineForButton:cardButton];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.detailsLabel.text = stringForDetails;
}
- (IBAction)deal:(id)sender {
    self.game = nil;
    [self updateUI:@"New Game!"];
}

- (IBAction)flipCard:(UIButton *)sender {
    NSString *str = [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI:str];
}

- (void)viewDidLoad {
    [self setup];
    [self updateUI:nil];
    [super viewDidLoad];
}

@end
