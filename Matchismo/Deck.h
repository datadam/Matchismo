//
//  Deck.h
//  Matchismo
//
//  Created by Adam on 5/8/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
