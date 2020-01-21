﻿/* -------------------------------------------------------------------------
//	File Name	:	ErrorCheck.h
//	Author		:	Zhang Fan
//	Create Time	:	2012-3-19 16:49:55
//	Description	:   error check and code path control
//
// -----------------------------------------------------------------------*/

#ifndef __IKERRORCHECK_H__
#define __IKERRORCHECK_H__

// #define DISABLE_ASSERT

//---------------------------------------------------------------------------
#ifdef _MSC_VER
#define __X_FUNCTION__ __FUNCTION__
#else
#define __X_FUNCTION__ __PRETTY_FUNCTION__
#endif

#if defined(DEBUG) && !defined(DISABLE_ASSERT)

    #if defined (_WIN32) || defined(_WIN64)              // Windows
        #include <crtdbg.h>
        #define IKAssert(exp)                   \
        do                                      \
        {                                       \
            _ASSERT(exp);                       \
        } while (0)
        
    #elif defined (__APPLE__)
		#include "TargetConditionals.h"
		#if defined(TARGET_OS_IPHONE) || defined(TARGET_IPHONE_SIMULATOR)
			#if defined(__i386__) || defined(__x86_64__) // iOS simulator
				#define IKAssert(exp)					\
				do                                      \
				{                                       \
					if (!(exp))							\
                    {                                   \
                        DDLogError(@"Assert Faild: %s", #exp);				\
						asm("int $3");					\
                    }                                   \
				} while (0)

			#elif defined(__arm__) || defined(__arm64__) // iOS device
				#include <signal.h>
				#include <pthread.h>

				#define IKAssert(exp)								\
				do													\
				{													\
					if (!(exp))										\
                    {                                               \
                        DDLogError(@"Assert Faild: %s", #exp);				\
						pthread_kill(pthread_self(), SIGINT);		\
                    }                                               \
				} while (0)
			#endif

		#elif defined(TARGET_OS_MAC)					 // Mac OS
			#include <CoreFoundation/CoreFoundation.h>
			#define IKAssert(exp)\
			do                                      \
			{                                       \
				if (!(exp))                         \
				{                                   \
					CFUserNotificationDisplayAlert(10, kCFUserNotificationNoteAlertLevel, NULL, NULL, NULL, CFSTR(#exp), NULL, NULL, NULL, NULL, NULL);\
					asm("int $3");                  \
				}                                   \
			} while (0)
		#endif
    #else                                                 // Linux and other
        #include <assert.h>
        #define IKAssert(exp)					\
        do                                      \
        {                                       \
            assert(exp);                        \
        } while (0)
        
    #endif
#else
    #ifdef __OBJC__
        #define IKAssert(exp)						\
        do                                          \
        {                                           \
            if (!(exp))                             \
                DDLogError(@"Assert Faild: %s", #exp);				\
        } while (0)
    #else
        #define IKAssert(exp)						 (void)0
    #endif
#endif

// -------------------------------------------------------------------------

#define IKCheck(exp)                                                        \
    do {																	\
        if (!(exp))															\
        {																	\
            goto IKExit;													\
        }																	\
    } while(0)

#define IKErrorCheck(exp)                                                   \
    do {																	\
    if (!(exp))															    \
        {																	\
            IKAssert(!"IKErrorCheck: " #exp);                               \
            goto IKExit;													\
        }																	\
    } while(0)

#define IKCheckEx(exp, exp1)                                                \
    do {																	\
    if (!(exp))															    \
        {																	\
            exp1;															\
            goto IKExit;													\
        }																	\
    } while(0)

#define IKErrorCheckEx(exp, exp1)                                           \
    do {																	\
    if (!(exp))			    												\
        {																	\
            IKAssert(!"IKErrorCheckEx: " #exp);								\
            exp1;															\
            goto IKExit;													\
        }																	\
    } while(0)

#define IKQuit()            \
    do                      \
    {                       \
        goto IKExit;        \
    } while (0)

//--------------------------------------------------------------------------
#endif /* __IKERRORCHECK_H__ */
