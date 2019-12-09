# https://github.com/cloudwebrtc/flutter-webrtc-demo
# - Uses the Google Flutter Desktop.


# TODO: Mac os needs to copy the Runner project from flutter-desktop-embedding to create a demo.


LIB_NAME=flutter-webrtc-demo
LIB=github.com/cloudwebrtc/$(LIB_NAME)
#LIB_BRANCH=desktop
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

# Flutter tools
MAKE_IMPORT=$(GOPATH)/src/github.com/winwisely99/mod-videoconf/google-flutter-desktop


print:
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)

	@echo MAKE_IMPORT: $(MAKE_IMPORT)
	cd $(MAKE_IMPORT) && ls -al
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
	flutter upgrade

# Google Flutter Desktop
export ENABLE_FLUTTER_DESKTOP=true
SAMPLE=
SAMPLE_FSPATH=$(LIB_FSPATH)

flu-print:
	@echo SAMPLE: $(SAMPLE)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)

	cd $(MAKE_IMPORT) && $(MAKE) flu-config-print

flu-fix:
	# https://github.com/flutter/flutter/issues/20685

	# 1
	# open xcode
	cd $(SAMPLE_FSPATH)/ios && open Runner.xcodeproj
	# File > Project Settings : Build System: "New Build System(Default)

	# 2
	# edit pod file to include this: https://github.com/flutter/flutter/blob/master/examples/platform_view/ios/Podfile#L78
	# Add:
	# install! 'cocoapods', :disable_input_output_paths => true
	cd $(SAMPLE_FSPATH)/ios && code Podfile

	# 3
	cd $(SAMPLE_FSPATH)/ios && pod install

flu-mob-run-debug:
	# Make sure that "$(MAKE) flu-config-mobile" is run from another bash terminal first

	
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-mobile
	#cd $(LIB_FSPATH) && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get

	cd $(SAMPLE_FSPATH) && flutter run -d all
	#cd $(SAMPLE_FSPATH) && flutter run -d "iPad (5th generation)" --track-widget-creation --profile
	#cd $(SAMPLE_FSPATH) && flutter run -d "Nexus 5X" --track-widget-creation --profile
	

flu-mob-run:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-mobile
	#cd $(LIB_FSPATH) && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get
	
	cd $(SAMPLE_FSPATH) && flutter run -d all
	#cd $(SAMPLE_FSPATH) && flutter run -d "iPhone 11 Pro Max "
	#cd $(SAMPLE_FSPATH) && flutter run -d "iPad (5th generation)"	
	#cd $(SAMPLE_FSPATH) && flutter run -d "Nexus 5X"

flu-desk-run:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-desktop

	#cd $(LIB_FSPATH) && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get
	#cd $(LIB_FSPATH) && flutter pub get
	cd $(SAMPLE_FSPATH) && flutter run -d "macOS"


flu-web-run:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-web

	#cd $(LIB_FSPATH) && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get
	#cd $(LIB_FSPATH) && flutter pub get
	cd $(SAMPLE_FSPATH) && flutter run 
	
flu-web-open:
	open http://$(LIB)