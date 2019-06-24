

#import "LoginViewController.h"

#import "CBLoginCenter.h"

@interface CBLoginCenter ()

@property (nonatomic, assign, readwrite) CBLoginCenterState loginState;
@property (nonatomic, strong, readwrite) CBModelLogin* sessionInfo;

@end


@implementation CBLoginCenter


+ (instancetype)instance {
    static dispatch_once_t onceToken;
    static id _shareinstaben = nil;
    dispatch_once(&onceToken, ^{
        _shareinstaben = [[self alloc] init];
    });
    return _shareinstaben;
}

- (instancetype)init {
    if (self = [super init]) {
        [self dataLoad];
        self.loginState = CBLoginCenterStateNotLogin;
    }
    return self;
}

- (void)loginWithBlock:(CBLoginCenterResult)block {
    if ( self.loginState == CBLoginCenterStateLogin
        && self.sessionInfo.account.length
        && self.sessionInfo.userToken.length ) {
        if (block) {
            block(YES);
        }
    } else if (self.loginState != CBLoginCenterStateLogining) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        if (keyWindow.rootViewController) {
            self.loginState = CBLoginCenterStateLogining;
            @weakify(self);
            __block LoginViewController* loginVC = [[LoginViewController alloc] initWithBlock:^(CBModelLogin *dataModel) {
                @strongify(self);
                self.sessionInfo = dataModel;
                self.loginState = CBLoginCenterStateLogin;
                [loginVC dismissViewControllerAnimated:YES completion:nil];
                block(YES);
            }];
            UIViewController *c = keyWindow.rootViewController;
            [c presentViewController:loginVC animated:YES completion:nil];
        }
    }
}

- (void)logout {
    self.sessionInfo = nil;
    self.loginState = CBLoginCenterStateNotLogin;
}



- (void)dataLoad
{
#define dataLoadProperty(key) \
    { \
        NSData* data = [NSUserDefaults.standardUserDefaults dataForKey:NSStringFromSelector(@selector(key))]; \
        self.key = (id)[CBModelBase unarchiveFromData:data]; \
    }

    
    dataLoadProperty(sessionInfo);
    self.loginState = [NSUserDefaults.standardUserDefaults integerForKey:NSStringFromSelector(@selector(loginState))];
}

- (void)dataSave
{
#define dataSaveProperty(key) \
    if (self.key) { \
        [NSUserDefaults.standardUserDefaults setObject:self.key.archiveToData forKey:NSStringFromSelector(@selector(key))]; \
    } else { \
        [NSUserDefaults.standardUserDefaults removeObjectForKey:NSStringFromSelector(@selector(key))]; \
}
    
    dataSaveProperty(sessionInfo);
    [NSUserDefaults.standardUserDefaults setInteger:self.loginState forKey:NSStringFromSelector(@selector(loginState))];
    
    [NSUserDefaults.standardUserDefaults synchronize];
}

@end
