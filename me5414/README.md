# Decompressing MPSC files
```bash
./emps.sh
./a.out lotfi.mpsc >> lotfi.mps
./a.out fit1p.mpsc >> fit1p.mps
./a.out fit1d.mpsc >> fit1d.mps
./a.out maros-r7.mpsc >> maros-r7.mps
```


# Measuring runtime

https://docs.python.org/3/library/timeit.html#command-line-interface
```bash
python -m timeit  "$(cat mini_proj.py)"
python -m timeit -n 1  "$(cat mini_proj.py)"
```