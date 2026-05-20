#!/bin/bash
(set -o igncr) 2>/dev/null && set -o igncr; # comment is needed
PYO3_PYTHON_64=C:/Users/neils/AppData/Local/Python/pythoncore-3.13-64
PYO3_PYTHON_32=C:/Software/Python/Python311-32
export PYO3_PYTHON_64 PYO3_PYTHON_32
STFLAGS='-C linker=lld'
echo "before cargo build"
PYO3_PYTHON=${PYO3_PYTHON_64}/python.exe STFLAGS="$STFLAGS" cargo build --target x86_64-pc-windows-msvc --release
echo "after cargo build"

echo "before cp target/x86_64-pc-windows-msvc/release/libmathcat_py.dll addon/globalPlugins/MathCAT/libmathcat_py.pyd"

cp target/x86_64-pc-windows-msvc/release/libmathcat_py.dll addon/globalPlugins/MathCAT/libmathcat_py.pyd

# for testing
cp target/x86_64-pc-windows-msvc/release/libmathcat_py.dll Example/libmathcat_py.pyd
cp -r addon/globalPlugins/MathCAT/Rules Example
sed 's/^import wx\.xrc/# import wx.xrc/' --in-place "addon/globalPlugins/MathCAT/MathCATgui.py"
rm -f MathCAT-*.nvda-addon

# use "pip install SCons" to add scons to the python env
${PYO3_PYTHON_64}/Scripts/scons
