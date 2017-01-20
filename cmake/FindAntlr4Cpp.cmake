CMAKE_MINIMUM_REQUIRED(VERSION 2.8.12.2)

find_path(ANTLR4CPP_INCLUDE_DIR 
  antlr4-runtime.h 
  HINTS ${ANTLR4CPP_INSTALL_DIR}/include/antlr4-runtime ${ANTLR4CPP_INSTALL_DIR}/include)

# Find static libraries
if(APPLE)
  set(_EXCLUDE_SUFFIX ".dylib")
elseif(UNIX)
  set(_EXCLUDE_SUFFIX ".so")
else()
  set(_EXCLUDE_SUFFIX ".dll")
endif()
list(REMOVE_ITEM CMAKE_FIND_LIBRARY_SUFFIXES ${_EXCLUDE_SUFFIX})
find_library(ANTLR4CPP_STATIC_LIBS
  antlr4-runtime 
  ${ANTLR4CPP_INSTALL_DIR}/lib)
list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ${_EXCLUDE_SUFFIX})
if(NOT ANTLR4CPP_STATIC_LIBS-NOTFOUND)
  list(APPEND ANTLR4CPP_LIBS ${ANTLR4CPP_STATIC_LIBS})
endif()

# Find dynamic libraries
if(UNIX)
  set(_EXCLUDE_SUFFIX ".a")
else()
  set(_EXCLUDE_SUFFIX ".lib")
endif()
list(REMOVE_ITEM CMAKE_FIND_LIBRARY_SUFFIXES ${_EXCLUDE_SUFFIX})
find_library(ANTLR4CPP_SHARED_LIBS
  antlr4-runtime 
  ${ANTLR4CPP_INSTALL_DIR}/lib)
list(APPEND CMAKE_FIND_LIBRARY_SUFFIXES ${_EXCLUDE_SUFFIX})
if(NOT ANTLR4CPP_SHARED_LIBS-NOTFOUND)
  list(APPEND ANTLR4CPP_LIBS ${ANTLR4CPP_SHARED_LIBS})
endif()

unset(_EXCLUDE_SUFFIX)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Antlr4Cpp 
  "Can't find Antlr4Cpp runtime related files. Do you setup ANTLR4CPP_INSTALL_DIR?"
  ANTLR4CPP_INCLUDE_DIR ANTLR4CPP_LIBS)

list(APPEND ANTLR4CPP_INCLUDE_DIRS ${ANTLR4CPP_INCLUDE_DIR})
foreach(src_path misc atn dfa tree support)
  list(APPEND ANTLR4CPP_INCLUDE_DIRS ${ANTLR4CPP_INCLUDE_DIR}/${src_path})
endforeach(src_path)

mark_as_advanced(ANTLR4CPP_INCLUDE_DIR)
