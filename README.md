# Purpose

Use this script to test the read and write speed in several filesystem in the cluster when you suspect a filesystem you are using is overloaded and slow.

# Installation

1. This is a simple `bash` script, so you can install it by cloning this repo, or simply running:

```
wget https://raw.githubusercontent.com/leoisl/test_disk_speed_in_cluster/master/test_disk_speed_in_cluster.sh
```

2. Give execution permissions:
```
chmod +x test_disk_speed_in_cluster.sh
```

# Usage

Please provide paths to directories **(they must already exist!!)** inside the filesystems you want to test.

Example:
```
bash test_disk_speed_in_cluster.sh /nfs/research/zi/leandro/temp /lscratch/temp/ /hps/nobackup/iqbal/leandro/test  10000 1
```

This will test the disk speed in `/nfs/research`, `/lscratch` and `/hps/nobackup`.

The test will write and read 10000 files of 1KB each.

Please be in a worker node, so you have write acess to all filesystems.

This is not a perfect test, but can give you hints.



# Running

Template:
```
./test_disk_speed_in_cluster.sh <directory_1> <directory_2> ... <directory_n> <number_of_files> <size_of_files_in_KB>
```

Example:
```
bash test_disk_speed_in_cluster.sh /nfs/research/zi/leandro/temp /lscratch/temp/ /hps/nobackup/iqbal/leandro/test  10000 1
```

Output of the example:

```
------------------------------------------------------------------------
Testing /nfs/research/zi/leandro/temp ...
Creating random file...
Writing and reading 10000 files, each with size 1 KB:
8142848 bytes (8.1 MB, 7.8 MiB) copied, 3 s, 2.7 MB/s
10000+0 records in
10000+0 records out
10240000 bytes (10 MB, 9.8 MiB) copied, 3.78854 s, 2.7 MB/s
------------------------------------------------------------------------
------------------------------------------------------------------------
Testing /lscratch/temp/ ...
Creating random file...
Writing and reading 10000 files, each with size 1 KB:
6859776 bytes (6.9 MB, 6.5 MiB) copied, 2 s, 3.4 MB/s
10000+0 records in
10000+0 records out
10240000 bytes (10 MB, 9.8 MiB) copied, 2.99414 s, 3.4 MB/s
------------------------------------------------------------------------
------------------------------------------------------------------------
Testing /hps/nobackup/iqbal/leandro/test ...
Creating random file...
Writing and reading 10000 files, each with size 1 KB:
10206208 bytes (10 MB, 9.7 MiB) copied, 233 s, 43.8 kB/s
10000+0 records in
10000+0 records out
10240000 bytes (10 MB, 9.8 MiB) copied, 233.349 s, 43.9 kB/s
------------------------------------------------------------------------
```

That means that `/nfs` disk speed is `2.7 MB/s`, `/lscratch` is `3.4 MB/s`, and `/hps/nobackup` is `43.9 kB/s`. Please interpret these values as approximations.
