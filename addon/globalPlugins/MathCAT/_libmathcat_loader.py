# -*- coding: UTF-8 -*-

"""Loads the libmathcat_py extension module matching the running process's bitness.

Both a 32-bit and a 64-bit build of libmathcat_py ship in this addon so a single
package works under both 32-bit and 64-bit NVDA.
"""

import importlib.util
import os
import sys

# checking for 64 vs 32-bit: https://docs.python.org/3/library/platform.html#cross-platform
_bitness = "x64" if sys.maxsize > 2**32 else "x86"
_pyd_path = os.path.join(os.path.dirname(__file__), f"libmathcat_py_{_bitness}.pyd")

_spec = importlib.util.spec_from_file_location("libmathcat_py", _pyd_path)
libmathcat = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(libmathcat)
