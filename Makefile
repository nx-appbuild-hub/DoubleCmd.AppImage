# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

all: clean
	rm -rf $(PWD)/build
	mkdir -p $(PWD)/build

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/updates/32/Everything/x86_64/Packages/d/doublecmd-qt-0.9.9-1.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/fedora/linux/releases/32/Everything/x86_64/os/Packages/d/doublecmd-common-0.9.7-1.fc32.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..



	mkdir -p $(PWD)/AppDir/application

	cp -r $(PWD)/build/usr/lib64/doublecmd/* $(PWD)/AppDir/application
	rm -f $(PWD)/AppDir/application/highlighters
	rm -f $(PWD)/AppDir/application/language
	rm -f $(PWD)/AppDir/application/pixmaps
	rm -f $(PWD)/AppDir/application/doc

	cp -r --force $(PWD)/build/usr/share/doublecmd/highlighters $(PWD)/AppDir/application/
	cp -r --force $(PWD)/build/usr/share/doublecmd/language $(PWD)/AppDir/application/
	cp -r --force $(PWD)/build/usr/share/doublecmd/pixmaps $(PWD)/AppDir/application/
	cp -r --force $(PWD)/build/usr/share/doublecmd/doc $(PWD)/AppDir/application/

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/qt5-qtbase-5.12.5-4.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/qt5-qtbase-gui-5.12.5-4.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/qt5-qtx11extras-5.12.5-1.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libpng-1.5.13-7.el7_2.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/libicu-60.3-2.el8_1.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/pcre2-utf16-10.23-2.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/libxcb-1.13-1.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm https://download-ib01.fedoraproject.org/pub/epel/8/Everything/x86_64/Packages/q/qt5pas-2.6-2001002.el8.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..

	wget --no-check-certificate --output-document=$(PWD)/build/build.rpm http://mirror.centos.org/centos/7/os/x86_64/Packages/openssl-libs-1.0.2k-19.el7.x86_64.rpm
	cd $(PWD)/build && rpm2cpio $(PWD)/build/build.rpm | cpio -idmv && cd ..



	mkdir -p $(PWD)/AppDir/lib
	cp -r --force $(PWD)/build/usr/lib64/* $(PWD)/AppDir/lib
	cp -r --force $(PWD)/AppDir/lib/qt5/plugins/platforms $(PWD)/AppDir/application/
	rm -rf $(PWD)/build/*

	export ARCH=x86_64 && $(PWD)/bin/appimagetool-x86_64.AppImage  $(PWD)/AppDir $(PWD)/DoubleCmd.AppImage
	@echo "done: DoubleCmd.AppImage"
	make clean


clean:
	rm -rf ${PWD}/AppDir/application
	rm -rf ${PWD}/AppDir/lib
	rm -rf ${PWD}/build
