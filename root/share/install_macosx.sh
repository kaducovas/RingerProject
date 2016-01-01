
export CXXFLAGS="-m64 -arch x86_64"
export CFLAGS="  -m64 -arch x86_64"
export LDFLAGS=" -m64 -arch x86_64"

rm -rf InstallArea/

#download rootcore 
svn co svn+ssh://jodafons@svn.cern.ch/reps/atlasoff/PhysicsAnalysis/D3PDTools/RootCore/tags/`svn ls svn+ssh://jodafons@svn.cern.ch/reps/atlasoff/PhysicsAnalysis/D3PDTools/RootCore/tags | tail -n 1` RootCore
source RootCore/scripts/setup.sh
#brew update
#brew install gcc5
#sudo pip install scipy
#sudo pip install numpy==1.8.0
#sudo pip install scikit-learn
#sudo pip install cython

mkdir InstallArea
#remove and adapt compile definitions
cd RingerCore/cmt
rm precompile.RootCore
$ROOTCOREDIR/scripts/set_field.sh Makefile.RootCore \
      PACKAGE_OBJFLAGS " -std=c++11 -fPI"\
      PACKAGE_LDFLAGS  ""
cd ../..
cd TuningTool/cmt
rm precompile.RootCore
$ROOTCOREDIR/scripts/set_field.sh Makefile.RootCore \
      PACKAGE_OBJFLAGS " -std=c++11 -fPI"\
      PACKAGE_LDFLAGS  ""
cd ../..

source buildthis.sh


cd InstallArea/
INSTALL_AREA=$(pwd)


#Armadillo
#scp -r jodafons@lxplus.cern.ch:/afs/cern.ch/work/j/jodafons/public/armadillo-6.400.2.tar .
cp ~/Public/armadillo-6.400.3.tar .
tar -vxf armadillo-6.400.3.tar
rm armadillo-6.400.3.tar
cd armadillo-6.400.3
./configure
cmake  -DCMAKE_OSX_ARCHITECTURES="x86_64" -DCMAKE_CXX_COMPILER=g++-5 -DCMAKE_CC_COMPILER=gcc-5 .
make install
cd ../

#ExMachina 
#git clone https://github.com/Tiamaty/ExMachina.git
cp -r ~/Public/ExMachina .
cd ExMachina/
export ARMADILLO_LIB_PATH=/usr/local/lib
export ARMADILLO_INCLUDE_PATH=/usr/local/include
python setup.py build_ext --build-lib='./build'
PYTHONPATH=$PYTHONPATH:$INSTALL_AREA/ExMachina/build
cd ../..

