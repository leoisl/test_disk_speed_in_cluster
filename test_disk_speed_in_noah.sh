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
hps_nobackup_folder="/hps/nobackup/research/zi/${user}"
nfs_folder="/nfs/research1/zi/${user}"
covid_folder="/hps/covid19_nobackup2/research/zi/${user}"

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
test_disk_speed_in_folder "$hps_nobackup_folder"
test_disk_speed_in_folder "$nfs_folder"
test_disk_speed_in_folder "$covid_folder"
