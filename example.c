#include <libkern/libkern.h>
#include <mach/mach_types.h>

kern_return_t
example_start(__attribute__((unused)) kmod_info_t *ki,
              __attribute__((unused)) void *d) {
	printf(KEXTNAME_S ": start\n");
	return KERN_SUCCESS;
}

kern_return_t
example_stop(__attribute__((unused)) kmod_info_t *ki,
             __attribute__((unused)) void *d) {
	printf(KEXTNAME_S ": stop\n");
	return KERN_SUCCESS;
}

extern kern_return_t _start(kmod_info_t *ki, void *d);
extern kern_return_t _stop(kmod_info_t *ki, void *d);

KMOD_EXPLICIT_DECL(BUNDLEID, KEXTBUILD_S, _start, _stop)
__private_extern__ kmod_start_func_t *_realmain = example_start;
__private_extern__ kmod_stop_func_t *_antimain = example_stop;
__private_extern__ int _kext_apple_cc = __APPLE_CC__;

