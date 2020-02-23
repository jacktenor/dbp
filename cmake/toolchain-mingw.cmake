# Based on http://pkgs.fedoraproject.org/cgit/mingw-filesystem.git/tree/Toolchain-mingw64.cmake?id=fcb9178d
# and https://aur.archlinux.org/packages/mingw-w64-cmake/

set(MINGW_TRIPLET i686-w64-mingw32)
set(MINGW_ROOT_PATH /usr/i686-w64-mingw32/sys-root/mingw)

set(CMAKE_SYSTEM_NAME Windows)

# Use static libraries only
set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")

# _CMAKE_TOOLCHAIN_PREFIX autodetection will not work if CMAKE_C_COMPILER is
# not set to the gcc binary (eg. if ccache is used), so set it manually here
set(_CMAKE_TOOLCHAIN_PREFIX "${MINGW_TRIPLET}-")

# specify the cross compiler
set(CMAKE_C_COMPILER ${MINGW_TRIPLET}-gcc)
set(CMAKE_CXX_COMPILER ${MINGW_TRIPLET}-g++)

# where is the target environment
set(CMAKE_FIND_ROOT_PATH ${MINGW_ROOT_PATH})

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Make sure Qt can be detected by CMake
set(QT_BINARY_DIR ${MINGW_ROOT_PATH}/bin /usr/bin)
set(QT_INCLUDE_DIRS_NO_SYSTEM ON)

# set the resource compiler (RHBZ #652435)
set(CMAKE_RC_COMPILER ${MINGW_TRIPLET}-windres)
set(CMAKE_MC_COMPILER ${MINGW_TRIPLET}-windmc)

# override boost thread component suffix as mingw-w64-boost is compiled with threadapi=win32
set(Boost_THREADAPI win32)

# These are needed for compiling lapack (RHBZ #753906)
set(CMAKE_Fortran_COMPILER ${MINGW_TRIPLET}-gfortran)
set(CMAKE_AR:FILEPATH ${MINGW_TRIPLET}-ar)
set(CMAKE_RANLIB:FILEPATH ${MINGW_TRIPLET}-ranlib)

# Run executables through wine
set(CMAKE_CROSSCOMPILING_EMULATOR wine)
