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

	mkdir -p $(PWD)/build
	apprepo --destination=$(PWD)/build appdir doublecmd doublecmd-qt doublecmd-plugins doublecmd-help-uk doublecmd-help-ru doublecmd-help-en doublecmd-common
	echo "exec \$${APPDIR}/lib64/doublecmd/doublecmd \"\$${@}\"" >> $(PWD)/build/Doublecmd.AppDir/AppRun

	rm -rf $(PWD)/build/Doublecmd.AppDir/*.desktop

	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Doublecmd.AppDir | true
	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Doublecmd.AppDir | true
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Doublecmd.AppDir | true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage  $(PWD)/build/Doublecmd.AppDir $(PWD)/DoubleCmd.AppImage
	chmod +x $(PWD)/DoubleCmd.AppImage

clean:
	rm -rf ${PWD}/AppDir/application
	rm -rf ${PWD}/AppDir/lib
	rm -rf ${PWD}/build
