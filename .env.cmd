@echo off

set OPEN_PROJECT_NAME=hug

set PROJECT_OPEN=
if "%PROJECT_NAME%"=="%OPEN_PROJECT_NAME%" set PROJECT_OPEN=1

if defined PROJECT_OPEN exit /b

if not exist ".env.cmd" exit /b

if not exist "venv" (
    echo Making venv for %OPEN_PROJECT_NAME%
    python -m venv venv || echo Make sure that you have Python ^>=3.3 installed and in your %%PATH%% && exit /b
    venv\Scripts\activate.bat
    pip install -r requirements\development.txt
    python setup.py install
)

venv\Scripts\activate.bat

git hf init || echo Make sure that git is installed and in your %%PATH%% && exit /b

set PROJECT_NAME=%OPEN_PROJECT_NAME%
set PROJECT_DIR=%CD%

rem Chaining macros isn't too straight forward, chaining commands can be done with $t
rem Quick directory switching
DOSKEY root=cd %PROJECT_DIR%
DOSKEY project=cd %PROJECT_DIR%\%PROJECT_NAME%
DOSKEY tests=cd %PROJECT_DIR%\tests
DOSKEY examples=cd %PROJECT_DIR%\examples
DOSKEY requirements=cd %PROJECT_DIR%\requirements
DOSKEY test=cd %PROJECT_DIR%\tests

DOSKEY open=cd %PROJECT_DIR%$t%CODE_EDITOR% hug\*.py setup.py tests\*.py examples\*.py examples\*\*.py README.md tox.ini .gitignore CHANGELOG.md setup.cfg .editorconfig .env .coveragerc .travis.yml

DOSKEY clean=cd %PROJECT_DIR%$tfco hug\*.py setup.py

DOSKEY check=cd %PROJECT_DIR%$tfrosted hug\*.py

DOSKEY _test=cd %PROJECT_DIR%$ttox

DOSKEY coverage=cd %PROJECT_DIR%$t%BROWSER% htmlcov\index.html

DOSKEY load=cd %PROJECT_DIR%$tpython setup.py install

DOSKEY unload=cd %PROJECT_DIR%$tpip uninstall hug

DOSKEY install=cd %PROJECT_DIR%$tsudo python setup.py install

DOSKEY update=cd %PROJECT_DIR%$tpip install -r requirements\development.txt -U

DOSKEY distribute=cd %PROJECT_DIR%$tpython setup.py sdist upload

DOSKEY leave=cd %PROJECT_DIR%$t.env_cleanup.cmd
