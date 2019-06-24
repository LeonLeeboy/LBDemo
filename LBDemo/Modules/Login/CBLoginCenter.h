

#import <Foundation/Foundation.h>
#import "CBModelLogin.h"


typedef enum : NSUInteger {
    CBLoginCenterStateNotLogin = 0,
    CBLoginCenterStateLogining,
    CBLoginCenterStateLogin
}CBLoginCenterState;

typedef void(^CBLoginCenterResult)(BOOL loginSuccess);
typedef void(^CBLoginCenterSignUpResult)(NSError* error);

@interface CBLoginCenter : NSObject

+ (instancetype)instance;

@property (nonatomic, assign, readonly) CBLoginCenterState loginState;
@property (nonatomic, strong, readonly) CBModelLogin * sessionInfo;


- (void)loginWithBlock:(CBLoginCenterResult)block;

@end
