//
//  UILabel+Normal.m
//  Advertising
//
//  Created by dingqiankun on 2019/11/30.
//  Copyright © 2019 rongshu. All rights reserved.
//

#import "UILabel+Normal.h"

@implementation UILabel (Normal)

- (void)changeStr:(NSString *)changeStr color:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSRange range;
    if (![changeStr isEmpty]) {
        range = [self.text rangeOfString:changeStr];
        [str addAttribute:NSForegroundColorAttributeName value:color range:range];
        if (font != nil) {
            [str addAttribute:NSFontAttributeName value:font range:range];
        }
        self.attributedText = str;
        [self sizeToFit];
    }
}

- (void)deleteLineFor:(NSString *)content
{
    NSAttributedString *attrStr =
    [[NSAttributedString alloc] initWithString:content
                                  attributes:
  @{NSFontAttributeName: self.font,
    NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#999999"],
    NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
    NSStrikethroughColorAttributeName:[UIColor colorWithHexString:@"#999999"]}];
    
    self.attributedText = attrStr;
}

-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];        //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

@end
