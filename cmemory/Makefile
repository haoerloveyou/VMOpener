ARCHS = armv7 arm64
TARGET = iPhone:clang:7.1:8.1
CFLAGS = -fobjc-arc
LDFLAGS = -F$(THEOS)/frameworks

export THEOS=/var/theos
include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = cmemory
cmemory_FILES = cmemory.mm $(shell find $(THEOS)/include/SettingsKit -name '*.m')
cmemory_INSTALL_PATH = /Library/PreferenceBundles
cmemory_FRAMEWORKS = UIKit MessageUI Social QuartzCore CoreGraphics
cmemory_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)cp $(THEOS)/include/SettingsKit/Resources/*.png $(THEOS_STAGING_DIR)/Library/PreferenceBundles/cmemory.bundle/$(ECHO_END)
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/cmemory.plist$(ECHO_END)
