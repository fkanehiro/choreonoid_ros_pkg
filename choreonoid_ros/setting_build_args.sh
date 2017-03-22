#!/bin/sh
# This script is setting CMake arguments for build of the Choreonoid.
#

#
# Variables.
#

# for cmake
_CNOID_ROS_PKG_BUILD_CNOID_USER_CMAKE_ARGS=""
_CNOID_ROS_PKG_BUILD_CNOID_CONSTANT_CMAKE_ARGS="
  -DENABLE_INSTALL_PATH=ON
  -DENABLE_PYTHON=ON
  "

# for make
_CNOID_ROS_PKG_BUILD_CNOID_MAKE_ARGS="-j 4"

#
# Main.
#

_dir=`dirname ${0}`
_fname=""

# NOTE: Currently, is based on the premise that the use of the gcc.
_gxxver=`g++ -dumpversion | sed -e 's/\.//'`
_cxx11flag=""

case ${1} in
  cmake)
    _fname="${_dir}/additional_cmake_args"

    if [ -f ${_fname} ]; then
      _CNOID_ROS_PKG_BUILD_CNOID_USER_CMAKE_ARGS=`cat ${_fname}`
    fi

    if [ ${_gxxver} -ge 47 ]; then
      _cxx11flag="-std=c++11"
    else
      _cxx11flag="-std=c++0x"
    fi

    echo -DCMAKE_CXX_FLAGS=${_cxx11flag} ${_CNOID_ROS_PKG_BUILD_CNOID_CONSTANT_CMAKE_ARGS} \
         ${_CNOID_ROS_PKG_BUILD_CNOID_USER_CMAKE_ARGS}
    ;;

  make)
    _fname="${_dir}/additional_make_args"

    if [ -f ${_fname} ]; then
      _CNOID_ROS_PKG_BUILD_CNOID_MAKE_ARGS=`cat ${_fname}`
    fi

    echo ${_CNOID_ROS_PKG_BUILD_CNOID_MAKE_ARGS}
    ;;

  *)
    echo "usage:" `basename ${0}` "[ cmake | make ]"  
    exit 1
    ;;
esac

exit 0
