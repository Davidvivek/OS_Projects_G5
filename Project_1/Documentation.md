# Project 1 — xv6 System Call Implementation
Name: Debanjali
Branch: debanjali-project1

## System Calls Implemented
1. getppid() — Returns parent process ID (Process Management)
2. ps() — Prints process table (Process Management)
3. trace() — Traces syscall usage via bitmask (IPC/Monitoring)
4. waitx() — Extended wait with runtime and waittime (Synchronization)
5. getcount() — Counts syscall invocations (Kernel Monitoring)

## How to Run
cd Project_1/xv6-riscv
make qemu
Then inside xv6: testppid / testps / testtrace / testwaitx / testcount
Exit: Ctrl+A then X

## Results
testppid  -> prints PID and parent PID correctly
testps    -> prints full process table
testtrace -> logs syscall 1 (fork) with return value
testwaitx -> prints child wait and run time
testcount -> fork=2, write=19, read=10
