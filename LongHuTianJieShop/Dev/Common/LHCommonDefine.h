//
//  LHCommonDefine.h
//  LongHuTianJieShop
//
//  Created by bytedance on 2021/3/2.
//

#ifndef LHCommonDefine_h
#define LHCommonDefine_h
#define SCREEN_WIDTH      CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT     CGRectGetHeight([[UIScreen mainScreen] bounds])

#ifndef WeakSelf
#define WeakSelf __weak typeof(self) wself = self
#endif
#ifndef StrongSelf
#define StrongSelf __strong typeof(wself) self = wself
#endif

#endif /* LHCommonDefine_h */
