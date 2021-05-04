# Usage

Please provide several paths to folders to filesystems you want to test.
Example: ./test_disk_speed_in_cluster.sh /hps/nobackup/iqbal/leandro/disk_test /nfs/research/zi/leandro/disk_test /hps/software/users/iqbal/leandro/disk_test
This will test the disk speed in /hps/nobackup, /nfs and /hps/software.
The test will create a random 1GB file in each folder, and will write and read 1024 files of 1MB each.
Please be in a worker node, so you have write acess to all filesystems.

# Running

