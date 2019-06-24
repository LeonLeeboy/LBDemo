

#import <Foundation/Foundation.h>
#import "CBModelLogin.h"

typedef void(^LoginBlock)(CBModelLogin* dataModel);
@interface LoginViewController : UIViewController

- (id)initWithBlock:(LoginBlock)block;

@end
