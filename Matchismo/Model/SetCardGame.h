//
//  SetCardGame.h
//  Matchismo
//
//  Created by Adam on 9/13/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCard.h"
#import "SetCardDeck.h"

@interface SetCardGame : NSObject
// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(SetCardDeck *)deck;

- (NSString *)flipCardAtIndex:(NSUInteger)index;

- (SetCard *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int sets;

@end
