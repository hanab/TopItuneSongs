//
//  UIFont+Brand.m
//  TopItuneSongs
//
//  Created by Hana  Demas on 8/26/20.
//  Copyright © 2020 ___HANADEMAS___. All rights reserved.
//

#import "UIFont+Brand.h"

@implementation UIFont (Brand)

+(UIFont *)itunesRegular:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue" size:size];
}

+(UIFont *)itunesBold:(CGFloat)size {
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
}
@end
