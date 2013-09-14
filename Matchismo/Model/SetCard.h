//
//  SetCard.h
//  Matchismo
//
//  Created by Adam on 9/5/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card
@property (nonatomic, strong) NSString *shape;
@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) NSString *shading;
+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShading;
- (NSAttributedString *)displayContents;
- (NSString *)regularContents;
@end
