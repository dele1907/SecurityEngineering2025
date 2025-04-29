#!/bin/bash

echo "content of archive.tar"
tar tvf archive.tar
echo "========================="

echo "content of archive.tar.gz"
tar tvf archive.tar.gz
echo "========================="

echo "content of archive.tar.gz2"
tar tvf archive.tar.bz2
echo "========================="

echo "content of archive.zip"
unzip -t archive.zip

# Dateien sind praktisch genau so groß wie Urpsrungsdatei
# weil sie zufällig ohne irgend ein Muster erstellt wurden,
# was es Kompressionsalgorithmen schwer macht, diese zu ver
# kleinern, weil diese solche Muster und viele Nullen ausnutzen.
# Außerdem speichern Kompressionsalgorithmen noch Metadaten


echo "content of archive0.tar"
tar tvf archive0.tar
echo "========================="

echo "content of archive0.tar.gz"
tar tvf archive0.tar.gz
echo "========================="

echo "content of archive0.tar.gz2"
tar tvf archive0.tar.bz2
echo "========================="

echo "content of archive0.zip"
unzip -t archive0.zip