//
//  SetCardGame.m
//  Matchismo
//
//  Created by Adam on 9/13/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()
@property (readwrite, nonatomic) int sets;
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation SetCardGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSArray *)findOtherFaceUpCards:(SetCard *)current {
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:2];
    for (SetCard *card in self.cards) {
        if (card == current) continue;
        else if (card.isFaceUp) {
            [arr addObject:card];
        }
    }
    NSArray *array = [[NSArray alloc] initWithArray:arr];
    return array;
}

- (NSString *)flipCardAtIndex:(NSUInteger)index {
    
    NSString *s = @"";
    SetCard *card = (SetCard *)[self cardAtIndex:index];
    if (card && !card.unplayable) {
        NSArray *a = [self findOtherFaceUpCards:card];
        if (!card.isFaceUp) {
            NSArray *a = [self findOtherFaceUpCards:card];
            if (a.count == 2) {
                int match = [card match:a];
                if (match) {
                    card.unplayable = YES;
                    card.faceUp = YES;
                    for (SetCard *otherCard in a) {
                        otherCard.unplayable = YES;
                        otherCard.faceUp = NO;
                    }
                    
                    self.sets += 1;
                    s = [NSString stringWithFormat:@"Found set %@, %@, and %@!", [card regularContents], [[a objectAtIndex:0] regularContents], [[a objectAtIndex:1] regularContents]];
                } else {
                    card.faceUp = NO;
                    for (SetCard *otherCard in a) {
                        otherCard.faceUp = NO;
                    }
                    s = [NSString stringWithFormat:@"%@, %@, and %@ are not a set!", [card regularContents], [[a objectAtIndex:0] regularContents], [[a objectAtIndex:1] regularContents]];
                }
            } else if (a.count == 1) {
                s = [NSString stringWithFormat:@"Selected %@ and %@!", [card regularContents], [[a objectAtIndex:0] regularContents]];
            } else if (a.count == 0){
                s = [NSString
                     stringWithFormat:@"Selected %@",
                     [card regularContents]];
            }
            card.faceUp = !card.isFaceUp;
        } else {
            card.faceUp = !card.isFaceUp;
            a = [self findOtherFaceUpCards:card];
            if (a.count == 1) {
                s = [NSString stringWithFormat:@"Selected %@!", [[a objectAtIndex:0] regularContents]];
            } else if (a.count == 0){
                s = @"";
            }
        }
    }
    return s;
}

- (SetCard *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(SetCardDeck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            SetCard *card = (SetCard *)[deck drawRandomCard];
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
