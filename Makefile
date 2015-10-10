TARGET := iphone:clang:7.1:8.1
ARCH := armv7 arm64
THEOS_DEVICE_IP = 192.168.0.101
THEOS_OBJ_DIR_NAME = obj
THEOS_PACKAGE_DIR_NAME = deb

export THEOS=/var/theos
GO_EASY_ON_ME = 1
include theos/makefiles/common.mk

TWEAK_NAME = Cmemorynew
Cmemorynew_FILES = Tweak.xm
Cmemorynew_FRAMEWORKS = UIKit


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
