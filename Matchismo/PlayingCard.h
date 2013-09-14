//
//  PlayingCard.h
//  Matchismo
//
//  Created by Adam on 5/8/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
