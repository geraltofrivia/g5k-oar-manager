""" We start off by some examples """

def get_stat():
    statdump = $(oarstat -u).strip()
    if statdump:
        op = {}
        rows = statdump.split('\n')[2:]
        for row in rows:
            row = row.split()
            jobid = row[0]
            jobstate = row[4]
            op[jobid] = jobstate
        print(op)
        return op
    else:
        print("NO Process found!")
        return None