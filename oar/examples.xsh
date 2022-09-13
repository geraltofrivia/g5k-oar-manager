""" We start off by some examples """
import time
from datetime import datetime
from pprint import pprint

def get_stat():
    statdump = $(oarstat -u).strip()
    if statdump:
        op = []
        rows = statdump.split('\n')[2:]
        for row in rows:
            row = row.split()
            jobid = row[0]
            jobstate = row[4]
            joblaunchdate = row[2]
            joblaunchtime = row[3]
            datetimeobj = datetime.fromisoformat(f"{joblaunchdate} {joblaunchtime}")
            _op = {
                'id': jobid,
                'state': jobstate,
                'timestamp': datetimeobj
            }
            op.append(_op)
        pprint(op)
        return op
    else:
        print("No Process found!")
        return None

def launch_process():
    """ For now, we want to launch another process, and not move away somehow"""
    oarsub -l gpu=1,walltime=1 "sleep infinity"

def delete_process(jobid: int):
    oardel @(jobid)

if __name__ == '__main__':
    get_stat()
    time.sleep(2)
    launch_process()
    get_stat()
    time.sleep(2)
    get_stat()
