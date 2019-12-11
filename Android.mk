LOCAL_PATH:= $(call my-dir)

# Build the MaruSettings APK
include $(CLEAR_VARS)

LOCAL_PACKAGE_NAME := MaruSettings
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true
LOCAL_MODULE_TAGS := optional
LOCAL_USE_AAPT2 := true

LOCAL_SRC_FILES := $(call all-java-files-under, src)
LOCAL_RESOURCE_DIR := $(LOCAL_PATH)/res

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

ifneq ($(INCREMENTAL_BUILDS),)
    LOCAL_PROGUARD_ENABLED := disabled
    LOCAL_JACK_ENABLED := incremental
    LOCAL_JACK_FLAGS := --multi-dex native
endif

LOCAL_STATIC_ANDROID_LIBRARIES := \
    android-support-v4 \
    android-support-v13 \
    android-support-v7-appcompat \
    android-support-v7-cardview \
    android-support-v7-preference \
    android-support-v7-recyclerview \
    android-support-v14-preference

include frameworks/base/packages/SettingsLib/common.mk

include $(BUILD_PACKAGE)

# Use the following include to make our test apk.
ifeq (,$(ONE_SHOT_MAKEFILE))
include $(call all-makefiles-under,$(LOCAL_PATH))
endif
