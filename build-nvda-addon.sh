#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # comment is needed
PYO3_PYTHON_64=C:/Software/Python/Python313
PYO3_PYTHON_32=C:/Software/Python/Python311-32
STFLAGS='-C linker=lld'
PYO3_PYTHON=$YO3_PYTHON_32/python.exe STFLAGS="$STFLAGS" cargo build --target i686-pc-windows-msvc --release


cp target/i686-pc-windows-msvc/release/libmathcat_py.dll addon/globalPlugins/MathCAT/libmathcat_py.pyd

# for testing
cp target/i686-pc-windows-msvc/release/libmathcat_py.dll Example/libmathcat_py.pyd
cp -r addon/globalPlugins/MathCAT/Rules Example
sed 's/^import wx\.xrc/# import wx.xrc/' --in-place "addon/globalPlugins/MathCAT/MathCATgui.py"
rm -f MathCAT-*.nvda-addon

# use "pip install SCons" to add scons to the python env
echo ${PYO3_PYTHON_32}
${PYO3_PYTHON_32}/Scripts/scons
