//
//  NSThread+Macro.h
//  Demo
//
//  Created by sddz_yuxiaohua on 15/10/10.
//  Copyright © 2015年 sddz_yuxiaohua (hangzhou) Network Co.,Ltd. All rights reserved.
//

#ifndef NSThread_Macro_h
#define NSThread_Macro_h

#import <Foundation/Foundation.h>

// print current thread call stack
#ifndef NEK_Thread_CallStack
#define NEK_Thread_CallStack() [NSThread callStackSymbols]
#endif

// check whether business code running on main thread
#ifndef NEK_MailThread_Assert
#define NEK_MailThread_Assert() \
do { \
    if (![NSThread isMainThread]) { \
        NSString* msg = [NSString stringWithFormat: \
                        @"%@: SHOULD called on the main thread %@ NOT on %@", \
                        self.class, \
                        [NSThread mainThread], \
                        [NSThread currentThread]]; \
        NSAssert(NO, msg); \
    } \
} while(0)
#endif

#endif /* NSThread_Macro_h */
