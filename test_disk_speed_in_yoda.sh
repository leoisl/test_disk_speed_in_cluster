#!/usr/bin/env bash
set -eu
# parameters
if [ $# -ne 1 ]
  then
    echo "Please provide your username (i.e. the name of your directory in /hps/nobackup/iqbal/)"
    exit 1
fi

# default configs
user=$1
hps_nobackup_folder="/hps/nobackup/iqbal/${user}"
hps_nobackup2_folder="/hps/nobackup2/iqbal/${user}"
nfs_folder="/nfs/leia/research/iqbal/${user}"

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
  dd if=random_1GB_file.txt of=temp.txt bs=1048576 count=1024 oflag=dsync status=progress
}

# testing
test_disk_speed_in_folder "$hps_nobackup_folder"
test_disk_speed_in_folder "$hps_nobackup2_folder"
test_disk_speed_in_folder "$nfs_folder"
