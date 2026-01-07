import os
from ExecutionTimer import ExecutionTimer


with ExecutionTimer():
    with ExecutionTimer(print_on_exit=False) as _std:
        import json
        import requests
        import shutil
        import pickle
        import clipboard
        import datetime
        import glob
        import re
        import subprocess
        import sys
        from pathlib import Path
        import time

    with ExecutionTimer(print_on_exit=False) as _cv2:
        import pandas as pd
        import numpy as np
        import cv2
    with ExecutionTimer(print_on_exit=False) as _fsutils:
        # Custom modules from PYTHONPATH
        from fsutils.img import Img
        from fsutils.video import Video
        from fsutils.dir import Dir, File

    with ExecutionTimer(print_on_exit=False) as _custom_utils:
        from custom.ThreadPoolHelper import Pool
        from custom.Color import bg, cprint, fg, style
        from ProgressBar import ProgressBar
        from custom.size import Size
        from custom.decorators import exectimer

    with ExecutionTimer(print_on_exit=False) as _other:
        # from rich import print
        from rich import inspect, pretty, traceback
        # traceback.install()
        pretty.install(expand_all=False)
        from rich.console import Console
        from rich.markdown import Markdown
        from rich.progress import BarColumn, Progress, SpinnerColumn, TextColumn
        from rich.table import Table
        from rich.syntax import Syntax

        # from hwutils import CpuData, Disk, Fan, GpuData, Interface
        # from Sensor import *


def show(frame: np.ndarray) -> None:
       cv2.imshow('FRAME', frame)
       cv2.waitKey()
       cv2.destroyAllWindows()
       return

print('''Import Times:
    {:<10} {}
    {:<10} {}
    {:<10} {}
    {:<10} {}
    {:<10} {}
'''.format(
        'Standard', _std,
        'data', _cv2,
        'fsutils', _fsutils,
        'utils', _custom_utils,
        'other', _other,
    )
)

console = Console()

