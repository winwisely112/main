

# https://github.com/cloudwebrtc/flutter-webrtc

# should work on desktop: https://github.com/cloudwebrtc/flutter-webrtc/pull/127


LIB_NAME=flutter-webrtc
LIB=github.com/cloudwebrtc/$(LIB_NAME)
#LIB_BRANCH=desktop
#LIB_BRANCH=flutter_web
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)



print:
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo

git-print:
	cd $(LIB_FSPATH) && git status
git-clone:
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
git-pull:
	cd $(LIB_FSPATH) && git pull
git-clean:
	rm -rf $(LIB_FSPATH)

WEBRTC_WORKSPACE=$(PWD)/../webrtc.code-workspace
code:
	code $(WEBRTC_WORKSPACE)
	#code $(LIB_FSPATH)

###


flu-os-dep:
	# Need master to have Google Desktop and Web available.
	flutter channel master
	flutter flutter upgrade


# Flutter tools
MAKE_IMPORT=$(GOPATH)/src/github.com/winwisely99/mod-videoconf/google-flutter-desktop

# Google FLutter Desktop
export ENABLE_FLUTTER_DESKTOP=true
SAMPLE=example
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE)
flu-print:
	@echo SAMPLE: $(SAMPLE)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)

	cd $(MAKE_IMPORT) && $(MAKE) flu-config-print

flu-fix:
	# https://github.com/flutter/flutter/issues/20685

	# open xcode
	cd $(SAMPLE_FSPATH)/ios && open Runner.xcodeproj
	# File > Project Settings : Build System: "New Build System(Default)

	# edit pod file to include this: https://github.com/flutter/flutter/blob/master/examples/platform_view/ios/Podfile#L78
	# Add:
	# install! 'cocoapods', :disable_input_output_paths => true
	cd $(SAMPLE_FSPATH)/ios && code Podfile

	cd $(SAMPLE_FSPATH)/ios && pod install

flu-mob-run:
	# works for IOS and android
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-mobile
	#cd $(LIB_FSPATH) && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get
	#cd $(SAMPLE_FSPATH) && flutter run -d all
	#cd $(SAMPLE_FSPATH) && flutter run -d "iPhone SE"
	cd $(SAMPLE_FSPATH) && flutter run -d all


flu-desk-run:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-desktop

	cd $(LIB_FSPATH) && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get
	#cd $(LIB_FSPATH) && flutter pub get
	cd $(SAMPLE_FSPATH) && flutter run -d "macOS"


flu-web-run:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-web

	#cd $(LIB_FSPATH) && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get
	#cd $(LIB_FSPATH) && flutter pub get
	cd $(SAMPLE_FSPATH) && flutter run -d chrome
	
flu-web-open:
	open http://$(LIB)