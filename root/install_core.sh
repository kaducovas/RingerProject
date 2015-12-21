
INSTALL_AREA=$(pwd)

mkdir InstallArea
cd InstallArea/

wget http://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $INSTALL_AREA/miniconda
PATH="$INSTALL_AREA/miniconda/bin:$PATH"

mkdir cython
conda install cython -p $INSTALL_AREA/cython --yes
PATH="$INSTALL_AREA/cython/bin:$PATH"

mkdir sklearn
conda install scikit-learn -p $INSTALL_AREA/sklearn --yes

mkdir cmake
conda install cmake -p $INSTALL_AREA/cmake --yes
PATH="$INSTALL_AREA/cmake/bin:$PATH"

cp /afs/cern.ch/work/j/jodafons/public/armadillo-6.400.2.tar .
tar -vxf armadillo-6.400.2.tar
rm armadillo-6.400.2.tar
cd armadillo-6.400.2/
cmake .
make install DESTDIR=$(pwd)
cd ..

#exmachina core
#git clone https://github.com/Tiamaty/ExMachina.git
cp -r /afs/cern.ch/work/j/jodafons/public/ExMachina .
cd ExMachina/
source install.sh \
  /tmp/jodafons/RingerProject/root/InstallArea/armadillo-6.400.2/usr/lib64 \
  /tmp/jodafons/RingerProject/root/InstallArea/armadillo-6.400.2/usr/include

PYTHONPATH=$PYTHONPATH:/build
cd ../..



