#!/bin/zsh

echo '====================================='
echo 'using sha256 on test.txt file'
sha256sum ./test.txt
echo '====================================='
echo

echo '====================================='
echo 'using sha1 on test.txt file'
sha1sum ./test.txt
echo '====================================='
echo

echo '====================================='
echo 'using sha384 on test.txt file'
sha384sum ./test.txt
echo '====================================='
echo

echo '====================================='
echo 'unsing md5 on test.txt file'
md5sum ./test.txt
echo '====================================='
echo

mv test.txt test2.txt

echo '====================================='
echo 'unsing md5 on test2.txt file after edit'
md5sum ./test2.txt
echo '====================================='
echo

mv test2.txt test.txt

echo '====================================='
echo 'using sha384 on test.txt file'
sha384sum ./test.txt
echo '====================================='

echo '====================================='
echo 'using openssl with sha256 on test.txt'
openssl dgst -sha256 test.txt
echo '====================================='
echo

echo '====================================='
echo 'uisng openssl with sha512 on test.txt'
openssl dgst -sha512 test.txt
echo '====================================='
echo

echo '====================================='
echo 'using openssl with whirlpool on test.txt'
openssl dgst -whirlpool test.txt
echo '====================================='
echo

echo '====================================='
echo 'using openssl with ripemd160'
openssl dgst -ripemd160 test.txt
echo '====================================='
echo
