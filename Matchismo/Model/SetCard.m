//
//  SetCard.m
//  Matchismo
//
//  Created by Adam on 9/5/13.
//  Copyright (c) 2013 Adam Taylor. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards {
    
    // If the array is the wrong size, we cannot check for matches!
    if (otherCards.count != 2) {
        return 0;
    }
    
    // We need to create a few objects to hold the 2 other cards
    SetCard *card2 = [otherCards objectAtIndex:0];
    SetCard *card3 = [otherCards objectAtIndex:1];
    
    // Check for shape
    if (
        (self.shape == card2.shape) &&
        (card2.shape == card3.shape) &&
        (card3.shape == self.shape));
    else if (
        (self.shape != card2.shape) &&
        (card2.shape != card3.shape) &&
        (card3.shape != self.shape));
    else return 0;
    
    // Check for color
    if (
        (self.color == card2.color) &&
        (card2.color == card3.color) &&
        (card3.color == self.color));
    else if (
        (self.color != card2.color) &&
        (card2.color != card3.color) &&
        (card3.color != self.color));
    else return 0;
    
    // Check for number
    if (
        (self.number == card2.number) &&
        (card2.number == card3.number) &&
        (card3.number == self.number));
    else if (
        (self.number != card2.number) &&
        (card2.number != card3.number) &&
        (card3.number != self.number));
    else return 0;
    
    // Check for shading
    if (
        (self.shading == card2.shading) &&
        (card2.shading == card3.shading) &&
        (card3.shading == self.shading));
    else if (
        (self.shading != card2.shading) &&
        (card2.shading != card3.shading) &&
        (card3.shading != self.shading));
    else return 0;
    
    // If the cards match properly then execution
    // will reach the bottom and we can safely
    // return that the cards were a match
    return 1;
}

+ (NSArray *)validShapes {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validColors {
    return @[[UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
}

+ (NSArray *)validShading {
    return @[@"NONE", @"PARTIAL", @"FULL"];
}

- (NSAttributedString *)displayContents {
    NSString *str = @"";
    
    for (NSUInteger i = 1; i <= self.number; i++) {
        str = [str stringByAppendingString:self.shape];
    }
    
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range;
    range.location = 0;
    range.length = [str length];
    
    UIColor *color;
    if ([self.shading isEqualToString:@"NONE"]) {
        color = [UIColor whiteColor];
    } else if ([self.shading isEqualToString:@"PARTIAL"]) {
        color = [self.color colorWithAlphaComponent:0.3];
    } else if ([self.shading isEqualToString:@"FULL"]) {
        color = self.color;
    }
    NSDictionary *d = @{ NSForegroundColorAttributeName: color,
                         NSStrokeWidthAttributeName: @-5,
                         NSStrokeColorAttributeName: self.color};
    [attstr addAttributes:d range:range];
    
    return [[NSAttributedString alloc] initWithAttributedString:attstr];
}

- (NSString *)regularContents {
    NSString *str = @"";
    
    for (NSUInteger i = 1; i <= self.number; i++) {
        str = [str stringByAppendingString:self.shape];
    }
    
    return str;
}

@end








