

#import <Foundation/Foundation.h>

@interface CBModelBase : NSObject <NSCoding>

@property (nonatomic, assign)   NSInteger   retCode;
@property (nonatomic, copy)     NSString *  retMsg;

- (NSData*)archiveToData;
+ (instancetype)unarchiveFromData:(NSData*)data;

- (BOOL)isEqual:(CBModelBase*)object;
@end


@interface CBModelBaseList : CBModelBase

@property (nonatomic, assign)   NSUInteger  listCount;
@property (nonatomic, assign)   BOOL        nextFlag;
@end

