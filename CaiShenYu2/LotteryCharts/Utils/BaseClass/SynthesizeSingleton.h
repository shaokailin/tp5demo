//
//  SynthesizeSingleton.h
//  SingleStore
//
//  Created by hsPlan on 2017/9/11.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#ifndef SynthesizeSingleton_h
#define SynthesizeSingleton_h

#define SYNTHESIZE_SINGLETON_CLASS(classname) \
\
__strong static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
static dispatch_once_t pred;\
dispatch_once(&pred, ^{\
shared##classname = [[super allocWithZone:NULL] init];\
});\
\
return shared##classname; \
} \
\

#endif /* SynthesizeSingleton_h */
