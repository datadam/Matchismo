//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Adam on 5/20/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (NSString *)flipCardAtIndex:(NSUInteger)index {
    NSString *str = @"";
    Card *card = [self cardAtIndex:index];
    if (card && !card.unplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        str = [NSString
                               stringWithFormat:@"Matched %@ & %@ for a score of %d!",
                               card.contents,
                               otherCard.contents,
                               matchScore * MATCH_BONUS];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        str = [NSString
                               stringWithFormat:@"%@ and %@ don't match! %d score penalty!",
                               card.contents,
                               otherCard.contents,
                               MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            if ([str isEqualToString:@""]) {
                str = [NSString
                       stringWithFormat:@"Flipped up %@",
                       card.contents];
            }
        } else {
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
    return str;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

@end
