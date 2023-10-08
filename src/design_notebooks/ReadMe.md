# Lab1 questions:

* The paths used by target_sources and target_include_directories are relative, not absolute. The folder they are in refference to is the same folder that has  the CMakeLists.txt file that you are using.

* CMake makes the build files but, ninja creates the executable 

* Its important to run the cmake files in its own directory so that the generated files don’t pollute our source code folder.