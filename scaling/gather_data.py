#!/usr/bin/env python

import glob
import pathlib
import csv
import math

def main():

    mdirs = ["amr", "flat"]
    hdirs = ["cpu", "gpu", "gpu-post-hackathon"]
    lst = []
    for mdir in mdirs:
        for hdir in hdirs:
            path = pathlib.Path(mdir) / pathlib.Path(hdir)
            for rdir in path.glob("*/"):
                fname = pathlib.Path(rdir) / "out.log"
                nranks = 0
                gpu = False
                times = []
                dt = 0.0
                ncells = 0
                try:
                    with open(fname, "r") as f:
                        for line in f:
                            if ("MPI initialized with" in line) and ("MPI processes" in line):
                                nranks = line.split()[3]
                            elif line.lstrip().startswith("GPU"):
                                gpu = line.split()[2] == "ON"
                            elif "WallClockTime" in line:
                                times.append(float(line.split()[-1]))
                            elif "Fixed timestepping with dt" in line:
                                dt = float(line.split()[5].replace(";", ""))
                            elif "cells" in line and "domain" in line:
                                ncells += int(line.split()[4])
                except FileNotFoundError:
                    continue

                if times:
                    print(f"Number of time steps ({gpu}, {mdir}, {nranks}): {len(times)}")
                    n_avg = 10
                    avg_time = 0.0
                    std = 0.0
                    for i in range(-n_avg, 0):
                        avg_time += times[i]
                    avg_time /= n_avg
                    for i in range(-n_avg, 0):
                        std += (times[i] - avg_time)**2
                    std = math.sqrt(std / (n_avg-1))
                    lst.append({"gpu": gpu, "mesh": mdir, "time": avg_time, "nranks": nranks, "dt": dt, "std": std, "ncells": ncells, "hdir": hdir})

    keys = lst[0].keys()
    fname = "scaling.csv"
    with open(fname, 'w', newline='') as f:
        dict_writer = csv.DictWriter(f, keys)
        dict_writer.writeheader()
        dict_writer.writerows(lst)

if __name__ == '__main__':
    main()
