#!/usr/bin/env bash
set -eu
# parameters
if [ $# -eq 0 ]
  then
    echo "Please provide paths to directories *(they must already exist!!)* inside the filesystems you want to test."
    echo "Example: ${0} /hps/nobackup/iqbal/leandro/disk_test /nfs/research/zi/leandro/disk_test /hps/software/users/iqbal/leandro/disk_test"
    echo "This will test the disk speed in /hps/nobackup, /nfs and /hps/software."
    echo "The test will create a random 1GB file in each directory, and will write and read 1024 files of 1MB each."
    echo "Please be in a worker node, so you have write acess to all filesystems."
    echo "This is not a perfect test, but can give you hints."
    exit 1
fi

# functions
make_random_1_GB_file() {
  echo "Creating random 1 GB file..."
  base64 /dev/urandom | head -c 1073741824 > random_1GB_file.txt
}

test_disk_speed_in_folder() {
  folder=$1
  echo "Testing $folder ..."
  cd "$folder"
  make_random_1_GB_file
  echo "Writing and reading 1024 files of 1MB each:"
  dd if=random_1GB_file.txt of=random_1GB_file.txt.dd bs=1048576 count=1024 oflag=dsync status=progress
}

# testing
for folder in "$@"
do
    test_disk_speed_in_folder "${folder}"
done
