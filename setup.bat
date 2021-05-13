@echo off

REM This setup is usefull when you have Laragon installed in the following directory: "C:/laragon"

REM I also assume that you already have php, node and git installed

set /p laravelDirectory="What is the name of the cloned repo? "

set projectDirectory=C:\laragon\www\%laravelDirectory%

cd %projectDirectory%

echo "Copying and renaming env file"
REM copy %projectDirectory%\.env.example %projectDirectory% && ren %projectDirectory%\.env.example %projectDirectory%\.env
type .env.example > .env    


echo "Generating key..."
start php artisan key:generate

echo "Running composer install..."
start composer install

echo "Scaffold bootstrap..."
start php artisan ui bootstrap --auth

echo "Running npm install..."
start npm install

set /p choice="Do you want wo start a local php server? (Y/N)"
if "%choice%"=="Y" goto Yes
if "%choice%"=="Y" goto No

:Yes
echo "Starting local php server..."
start php artisan serve
cmd
echo "Compiling assets in watch mode..."
start npm run watch

:No
echo "Compiling assets in watch mode..."
start npm run watch