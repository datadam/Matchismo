//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Adam on 9/5/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    self = [super init];
    if (self) {
        for (NSString *shape in [SetCard validShapes]) {
            for (int number = 1; number <= 3; number++) {
                for (UIColor *color in [SetCard validColors]) {
                    for (NSString *shading in [SetCard validShading]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.shape = shape;
                        card.number = number;
                        card.color = color;
                        card.shading = shading;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end
