//
//  TestGeneralKernel.c
//  TestGeneralKernel
//
//  Created by JianweiChen on 2020/1/30.
//  Copyright © 2020 inke. All rights reserved.
//

#include <mach/mach_types.h>
#include <libkern/libkern.h>

kern_return_t TestGeneralKernel_start(kmod_info_t * ki, void *d);
kern_return_t TestGeneralKernel_stop(kmod_info_t *ki, void *d);

kern_return_t TestGeneralKernel_start(kmod_info_t * ki, void *d)
{
    printf("TestGeneralKernel_start");
    return KERN_SUCCESS;
}

kern_return_t TestGeneralKernel_stop(kmod_info_t *ki, void *d)
{
    printf("TestGeneralKernel_start");
    return KERN_SUCCESS;
}
