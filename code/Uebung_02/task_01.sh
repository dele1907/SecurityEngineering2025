#!/bin/zsh

echo 'creating testfile with 1MB of random data'
# using bs=1048576 to create a 1MB file on Mac OS bs=1M does not work out of the box
dd if=/dev/urandom of=testfile bs=1048576 count=1
echo '====================================='
echo ''

echo 'creatting hardlink testlink -> testfile'
ln testfile testlink
echo '====================================='
echo ''

echo 'checking Inode number of testfile and testlink: should be identical'
ls -li testfile testlink
echo '====================================='
echo ''

echo 'archiving testfile and testlink into archive.tar'
# -c -> create archive
# -f -> filename of the archive
tar -cf archive.tar testfile testlink
echo '====================================='
echo ''

echo 'archiving testfile and testlink into archive.tar.gz'
# -z -> compress with gzip
tar -czf archive.tar.gz testfile testlink
echo '====================================='
echo ''

echo 'archiving testfile and testlink into archive.tar.bz2'
# -j -> compress with bzip2
tar -cjf archive.tar.bz2 testfile testlink
echo '====================================='
echo ''

echo 'archiving testfile and testlink into archive.tar.zip'
#zip does not svae hard link information
#therefore content will be copied, even both files are a reference to the same inode
# => size of archive will be larger than with tar
zip archive.zip testfile testlink
echo '====================================='
echo ''


#tar does recognize hard links and will not copy the content of the file
#hard link will be displayed as 'link to'
echo 'checking content of archive.tar'
tar -tvf archive.tar
echo '====================================='
echo ''

echo 'checking content of archive.tar.gz'
tar -tvf archive.tar.gz
echo '====================================='
echo ''

echo 'checking content of archive.tar.bz2'
tar -tvf archive.tar.bz2
echo '====================================='
echo ''

#zip does not recognize hard links and will copy the content of the file
echo 'checking content of archive.zip'
unzip -t archive.zip
echo '====================================='
echo ''

#expecting testfile and testlink to have the size of 1MB
#expecting archive.tar to have the size of 1MB -> testfile and testlink are hard links so only the content of one will be saved
#expecting archive.tar.gz to have the size of 1MB -> testfile and testlink are hard links so only the content of one will be saved
#expecting archive.tar.bz2 to have the size of 1MB -> testfile and testlink are hard links so only the content of one will be saved
#expecting archive.zip to have the size of 2MB -> testfile and testlink are copied

#random generated files will have no repetitive patterns, so there will be no compression up sides
#compression tools will only compress redundant data
ls -la testfile testlink archive.tar archive.tar.gz archive.tar.bz2 archive.zip
echo '====================================='
echo ''

echo 'perfoming cleanup'
rm testfile
rm testlink
rm archive.tar
rm archive.tar.gz
rm archive.tar.bz2
rm archive.zip
echo '====================================='
echo ''
echo 'cleanup done'
echo '====================================='
echo ''

echo 'creating testfile only containing 0'
dd if=/dev/zero of=testfileZero bs=1048576 count=1
echo '====================================='
echo ''

echo 'creating hardlink testlinkZero -> testfileZero'
ln testfileZero testlinkZero
echo '====================================='
echo ''

echo 'checking Inode number of testfileZero and testlinkZero: should be identical'
ls -li testfileZero testlinkZero
echo '====================================='
echo ''

echo 'archiving testfileZero and testlinkZero into archiveZero.tar'
tar -cf archiveZero.tar testfileZero testlinkZero
echo '====================================='
echo ''

echo 'archiving testfileZero and testlinkZero into archiveZero.tar.gz'
tar -czf archiveZero.tar.gz testfileZero testlinkZero
echo '====================================='
echo ''

echo 'archiving testfileZero and testlinkZero into archiveZero.tar.bz2'
tar -cjf archiveZero.tar.bz2 testfileZero testlinkZero
echo '====================================='
echo ''

echo 'archiving testfileZero and testlinkZero into archiveZero.tar.zip'
zip archiveZero.zip testfileZero testlinkZero
echo '====================================='
echo ''

echo 'checking content of archiveZero.tar'
tar -tvf archiveZero.tar
echo '====================================='
echo ''

echo 'checking content of archiveZero.tar.gz'
tar -tvf archiveZero.tar.gz
echo '====================================='
echo ''

echo 'checking content of archiveZero.tar.bz2'
tar -tvf archiveZero.tar.bz2
echo '====================================='
echo ''

echo 'checking content of archiveZero.zip'
unzip -t archiveZero.zip
echo '====================================='
echo ''

#expecting testfileZero and testlinkZero to have the size of 1MB
#expecting archiveZero.tar to have the size of 1MB
#expecting archiveZero.tar.gz to have the size of 1-2KB
#expecting archiveZero.tar.bz2 to have less size than .gz archive
#expecting archiveZero.zip to have the size of a few KB, but more than .bz2 file
#this is because /dev/zero is creating extremely redundant data -> efficient compression -> the more redundant data, the better the compression
ls -la testfileZero testlinkZero archiveZero.tar archiveZero.tar.gz archiveZero.tar.bz2 archiveZero.zip
echo '====================================='
echo ''

echo 'perfoming cleanup'
rm testfileZero
rm testlinkZero
rm archiveZero.tar
rm archiveZero.tar.gz
rm archiveZero.tar.bz2
rm archiveZero.zip
echo '====================================='
echo ''
echo 'cleanup done'
echo '====================================='
echo ''