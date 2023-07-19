#!/usr/bin/env bash
set -eu

# parameters
if [ $# -lt 3 ]
  then
    echo "Please provide paths to directories *(they must already exist!!)* inside the filesystems you want to test."
    echo "You also need to provide the number of files and the size of files (in kilobytes)."
    echo "Example: ${0} /hps/nobackup/iqbal/leandro/disk_test /nfs/research/zi/leandro/disk_test /hps/software/users/iqbal/leandro/disk_test 1000 1024"
    echo "This will test the disk speed in /hps/nobackup, /nfs and /hps/software. It will create 1000 files each of size 1024 KB."
    echo "The test will create a random 1GB file in each directory, and will write and read 1024 files of 1MB each."
    echo "Please be in a worker node, so you have write access to all filesystems."
    echo "This is not a perfect test, but can give you hints."
    exit 1
fi

# last two parameters are the number of files and the size of files
num_files=${@: -2:1}
file_size=${@: -1} # in kilobytes
# remove the last two parameters
set -- "${@:1:$(($#-2))}"

# functions
make_random_file() {
  # size of file is specified in kilobytes
  echo "Creating random file..."
  base64 /dev/urandom | head -c $(($file_size * $num_files * 1024)) > random_file.txt
}

test_disk_speed_in_folder() {
  folder=$1
  echo "Testing $folder ..."
  cd "$folder"
  make_random_file
  echo "Writing and reading file $num_files of size $file_size KB:"
  bs_bytes=$((1024*file_size)) # calculate block size in bytes
  dd if=random_file.txt of=random_file.txt.dd bs=$bs_bytes count=$num_files oflag=dsync status=progress
}

# testing
for folder in "$@"
do
    test_disk_speed_in_folder "${folder}"
done
