@echo on

set VERSION_qgis=981b8037c15e250d992e942d04f2728abe0add57
set URL_qgis=https://github.com/qgis/QGIS/archive/%VERSION_qgis%.tar.gz
set BUILD_qgis=%BUILD_PATH%\qgis
set REPO_qgis=%REPO_PATH%\qgis
if not exist %BUILD_qgis% mkdir %BUILD_qgis%

IF NOT EXIST %REPO_qgis% (
  cd %DOWNLOAD_PATH%
  curl -fsSL --connect-timeout 60  -o qgis.tar.gz %URL_qgis%
  7z x "qgis.tar.gz" -so | 7z x -aoa -si -ttar -o"src"
  move src\QGIS-%VERSION_qgis% %REPO_qgis%
)

cd %BUILD_qgis%
cmake -G %CMAKE_GENERATOR% ^
-DCMAKE_INSTALL_PREFIX:PATH=%STAGE_PATH% ^
-DWITH_DESKTOP=OFF ^
-DWITH_EPT=OFF ^
-DWITH_PDAL=OFF ^
-DDISABLE_DEPRECATED=ON ^
-DWITH_QTWEBKIT=OFF ^
-DWITH_QT5SERIALPORT=OFF ^
-DWITH_BINDINGS=OFF ^
-DWITH_INTERNAL_SPATIALITE=OFF ^
-DWITH_ANALYSIS=OFF ^
-DWITH_GRASS=OFF ^
-DWITH_GEOREFERENCER=OFF ^
-DCMAKE_DISABLE_FIND_PACKAGE_QtQmlTools=TRUE ^
-DWITH_QTMOBILITY=OFF ^
-DWITH_QUICK=OFF ^
-DENABLE_QT5=ON ^
-DENABLE_TESTS=OFF ^
-DWITH_QGIS_PROCESS=OFF ^
-DWITH_INTERNAL_QWTPOLAR=OFF ^
-DWITH_QWTPOLAR=OFF ^
-DWITH_GUI=OFF ^
-DWITH_APIDOC=OFF ^
-DWITH_ASTYLE=OFF ^
-DUSE_OPENCL=OFF ^
-DWITH_GRASS7:BOOL=OFF ^
-DPYTHON_EXECUTABLE:PATH=%PY36%/python.exe ^
-DFLEX_EXECUTABLE:PATH="C:/ProgramData/chocolatey/lib/winflexbison3/tools/win_flex.exe" ^
-DBISON_EXECUTABLE:PATH="C:/ProgramData/chocolatey/lib/winflexbison3/tools/win_bison.exe" ^
%REPO_qgis%

cmake --build . --config Release --target install --parallel %NUMBER_OF_PROCESSORS%

mkdir %STAGE_PATH%\cmake
mkdir %STAGE_PATH%\cmake\qgis
copy %REPO_qgis%\cmake\* %STAGE_PATH%\cmake\qgis\
