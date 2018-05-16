#!/bin/bash

set -e

cd `dirname $0`

for ext in "*.h" "*.cpp" "*.m" "*.mm"; do
	for dir in "../src"; do
		for f in `find $dir -name $ext`; do
			clang-format -style=file -i $f
		done
	done
done
