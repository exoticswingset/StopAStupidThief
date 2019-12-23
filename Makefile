INSTALL_TARGET_PROCESSES = SpringBoard
export ARCHS = armv7 armv7s arm64 arm64e
include ~/theos/makefiles/common.mk

TWEAK_NAME = StopAStupidThief

StopAStupidThief_FILES = Tweak.x
StopAStupidThief_CFLAGS = -fobjc-arc
StopAStupidThief_FRAMEWORKS = UIKit
include ~/theos/makefiles/tweak.mk
after-install::
	install.exec "killall -9 SpringBoard"
