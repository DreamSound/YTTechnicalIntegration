//
//  XYPhotoPickerBrowserPhoto.m
//  浏览器相册
//
//  Created by cyp on 16/3/15.
//  Copyright (c) 2016年 XY. All rights reserved.
//

#import "XYPhotoPickerBrowserPhoto.h"

@implementation XYPhotoPickerBrowserPhoto

- (void)setPhotoObj:(id)photoObj{
    _photoObj = photoObj;
    if ([photoObj isKindOfClass:[NSURL class]]){
        self.photoURL = photoObj;
    }else if ([photoObj isKindOfClass:[UIImage class]]){
        self.photoImage = photoObj;
    }else if ([photoObj isKindOfClass:[NSString class]]){
        self.photoPath = photoObj;
    }else{
        NSAssert(true == true, @"您传入的类型有问题");
    }
}
+ (instancetype)photoAnyImageObj:(id)imageObj{
    XYPhotoPickerBrowserPhoto *photo = [[self alloc] init];
    [photo setPhotoObj:imageObj];
    return photo;
}
- (instancetype)initWithAnyObj:(id)imageObj{
    if ((self = [super init])) {
        [self setPhotoObj:imageObj];
    }
    return self;
}





@end
