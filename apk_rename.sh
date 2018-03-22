#!/bin/bash

rename() {
	local manifest=$(tools/./aapt d badging "$1")
	local label=$(echo $manifest | grep -Po "(?<=application: label=')(.+?)(?=')")
	local package_name=$(echo $manifest | grep -Po "(?<=package: name=')(.+?)(?=')")
	local version_code=$(echo $manifest | grep -Po "(?<=versionCode=')(.+?)(?=')")
	local version_name=$(echo $manifest | grep -Po "(?<=versionName=')(.+?)(?=')")
	local apk_name="$label - $version_name - $version_code - $package_name.apk"
	local final_name=$(echo $apk_name | tr -d '\\' | tr -d '/')

	#if [ "$apk_name" == " -  -  - .apk" ];	then
	#	echo "🚫  $1 : faild to rename this file"
	#	return
	#fi

	echo
	mv -f "$1" "renamed/$final_name"
	echo "✅ Old name: $1 👇"
	echo "✅ New name: $final_name"
	echo
	echo "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "
	echo
}

for apk in input/*.apk
do
	rename "$apk"
done
