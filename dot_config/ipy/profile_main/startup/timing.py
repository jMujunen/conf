import time
from IPython.core.getipython import get_ipython
from ExecutionTimer import ExecutionTimer
from enum import Enum

class TimeUnits(Enum):
    ms = 1e-3
    seconds = 1
    minutes = 60
    hours = 60**2
    days = 24 * 60**2



def _time_cell():
    ip = get_ipython()
    end = time.time()
    if hasattr(ip, "start_time"):
        elapsed = end - ip.start_time
        if elapsed <= 0.005:
            elapsed = 0
        # print(f"Execution time: {elapsed:.4f} seconds")
        template = "Execution time: {minutes}{major_unit}{seconds} {minor_unit}"
        time_seconds = elapsed

        # Check if the time is less than a millisecond
        for unit in TimeUnits:
            if time_seconds < TimeUnits.seconds.value:
                print(template.format(
                    minutes="",
                    major_unit="",
                    seconds=f"{time_seconds / TimeUnits.ms.value:.0f}",
                    minor_unit=TimeUnits.ms.name,
                ))
                break
            if unit.name == "ms":
                continue
            time_seconds /= unit.value
            if time_seconds < TimeUnits.minutes.value:
                print(template.format(
                    minutes="",
                    major_unit="",
                    seconds=f"{time_seconds:.2f}",
                    minor_unit=unit.name,
                ))
                break
            if time_seconds < TimeUnits.hours.value:
                print(template.format(
                    minutes="",
                    major_unit="",
                    seconds=f"{time_seconds:.0f}",
                    minor_unit=unit.name,
                ))
                break
            time_seconds /= TimeUnits.minutes.value

    ip.start_time = end

ip = get_ipython()
ip.events.register("pre_execute", lambda: setattr(ip, "start_time", time.time()))
ip.events.register("post_execute", _time_cell)
