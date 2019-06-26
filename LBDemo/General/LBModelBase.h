

#import <Foundation/Foundation.h>

@interface LBModelBase : NSObject <NSCoding>

@property (nonatomic, assign)   NSInteger   retCode;
@property (nonatomic, copy)     NSString *  retMsg;

- (NSData*)archiveToData;
+ (instancetype)unarchiveFromData:(NSData*)data;

- (BOOL)isEqual:(LBModelBase*)object;
@end


