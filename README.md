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

Please provide paths to directories *(they must already exist!!)* inside the filesystems you want to test.

Example: `./test_disk_speed_in_cluster.sh /hps/nobackup/iqbal/leandro/disk_test /nfs/research/zi/leandro/disk_test /hps/software/users/iqbal/leandro/disk_test`

This will test the disk speed in `/hps/nobackup`, `/nfs` and `/hps/software`.

The test will create a random 1GB file in each directory, and will write and read 1024 files of 1MB each.

Please be in a worker node, so you have write acess to all filesystems.

This is not a perfect test, but can give you hints.



# Running

Template:
```
./test_disk_speed_in_cluster.sh <directory_1> <directory_2> ... <directory_n>
```

Example:
```
./test_disk_speed_in_cluster.sh /hps/nobackup/iqbal/leandro/disk_test /nfs/research/zi/leandro/disk_test /hps/software/users/iqbal/leandro/disk_test
```

Output of the example:

```
$ ./test_disk_speed_in_cluster.sh /hps/nobackup/iqbal/leandro/disk_test /nfs/research/zi/leandro/disk_test /hps/software/users/iqbal/leandro/disk_test
Testing /hps/nobackup/iqbal/leandro/disk_test ...
Creating random 1 GB file...
Writing and reading 1024 files of 1MB each:
1016070144 bytes (1.0 GB, 969 MiB) copied, 5 s, 203 MB/s
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 5.28495 s, 203 MB/s
Testing /nfs/research/zi/leandro/disk_test ...
Creating random 1 GB file...
Writing and reading 1024 files of 1MB each:
989855744 bytes (990 MB, 944 MiB) copied, 8 s, 124 MB/s
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 8.68435 s, 124 MB/s
Testing /hps/software/users/iqbal/leandro/disk_test ...
Creating random 1 GB file...
Writing and reading 1024 files of 1MB each:
973078528 bytes (973 MB, 928 MiB) copied, 5 s, 194 MB/s
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 5.44626 s, 197 MB/s
```

That means that `/hps/nobackup/` disk speed is `203 MB/s`, `/nfs` is `124 MB/s`, and `/hps/software` is `197 MB/s`. Please interpret these values as approximations. So it is safe to say that `/hps/nobackup/` and `/hps/software` has the same speed, while `/nfs` is almost twice slower.