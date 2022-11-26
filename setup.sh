#!/bin/bash
set -e

SCRIPT=`realpath $0`
DIR=`dirname $SCRIPT`

cd ${DIR}/bin

########## seqkit
echo "Installing seqkit ---------------------------------------------------------------------
"
wget https://github.com/shenwei356/seqkit/releases/download/v0.12.1/seqkit_linux_amd64.tar.gz --output-document 'seqkit_linux_amd64.tar.gz'
tar -zxvf seqkit_linux_amd64.tar.gz
rm seqkit_linux_amd64.tar.gz


########## Centrifuge
echo ""
echo "Intalling Centrifuge -------------------------------------------------------------------
"
wget ftp://ftp.ccb.jhu.edu/pub/infphilo/centrifuge/downloads/centrifuge-1.0.3-beta-Linux_x86_64.zip --output-document 'centrifuge-1.0.3-beta-Linux_x86_64.zip'
unzip centrifuge-1.0.3-beta-Linux_x86_64.zip
rm centrifuge-1.0.3-beta-Linux_x86_64.zip
rm -rf centrifuge
mv centrifuge-1.0.3-beta centrifuge



cd ${DIR}/database
# MetaPhlan2.0 markergene database ##############################
echo "
Downloading Metaphlan2 markergene database from git lfs"

git lfs install
git lfs pull

tar jxvf markers.fasta.tar.xz
echo "
Building lastdb for Metaphlan2 markergene database"
$DIR/bin/fastaNameLengh.pl markers.fasta > markers.fasta.length
# ${DIR}/bin/last-983/src/lastdb -Q 0 markers.lastindex markers.fasta -P 10

${DIR}/bin/last-1418/bin/lastdb -Q 0 -P 10 -uRY4 markers.lastindex2 markers.fasta 





########### lineage database ###################################################################
echo "
Downloading lineage information for NCBI taxonomy"

tar jxvf 2020-06-16_lineage.tab.tar.xz
mv database/2020-06-16_lineage.tab . 
rm -rf database



######### centrifuge database #################################
echo "
Downloading Centrifuge database"
wget https://genome-idx.s3.amazonaws.com/centrifuge/p_compressed%2Bh%2Bv.tar.gz --output-document 'p+b+v.tar.gz'
tar -zvxf p+b+v.tar.gz
rm p+b+v.tar.gz


echo "Finish Download required databases
------------------------------------------------------------------"
echo "Done metaRUpore setup"
