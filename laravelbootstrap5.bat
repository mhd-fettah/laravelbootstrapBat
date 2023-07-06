@echo off
echo o-------------------------------------------------------o
echo ^|o-----------------------------------------------------o^|
echo ^|^|                                                     ^|^|
echo ^|^|                                                     ^|^|
echo ^|^|                   SETUP SCRIPT                      ^|^|
echo ^|^|    Laravel with Laravel Mix and Bootstrap 5         ^|^|
echo ^|^|                                                     ^|^|
echo ^|^|                                                     ^|^|
echo ^|o-----------------------------------------------------o^|
echo o-------------------------------------------------------o
echo.

set /p projectName=Enter your project name:

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^| [1/8] Creating Laravel project named %projectName%                 ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o
echo.

composer create-project --prefer-dist laravel/laravel %projectName% -n
cd %projectName%

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^| [2/8] Setting up environment file and generating key  ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o
echo.

copy .env.example .env
php artisan key:generate

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^| [3/8] database information and updating .env file     ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o
echo.

set /p dbHost=Enter your database host (enter for nothing / localhost ):
set /p dbDatabase=Enter your database name :
set /p dbUsername=Enter your database username (enter for nothing / localhost ):
set /p dbPassword=Enter your database password (enter for nothing / localhost ):
echo Updating .env file with database information
powershell -Command "(gc .env) -replace 'DB_HOST=127.0.0.1', 'DB_HOST=%dbHost%' | Out-File -encoding ASCII .env"
powershell -Command "(gc .env) -replace 'DB_DATABASE=laravel', 'DB_DATABASE=%dbDatabase%' | Out-File -encoding ASCII .env"
powershell -Command "(gc .env) -replace 'DB_USERNAME=root', 'DB_USERNAME=%dbUsername%' | Out-File -encoding ASCII .env"
powershell -Command "(gc .env) -replace 'DB_PASSWORD=', 'DB_PASSWORD=%dbPassword%' | Out-File -encoding ASCII .env"

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^| [4/8] Installing Laravel UI and Bootstrap             ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o
echo.

composer require laravel/ui
php artisan ui bootstrap

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^| [5/8] Installing NPM dependencies                     ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o
echo.

npm install

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^| [6/8] Compiling assets                                ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o
echo.

npm run dev

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^| [7/8] Generating README.md file                       ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o
echo.

echo # %projectName% > README.md
echo # laravelTEST > README.md
echo This is a Laravel project with Laravel Mix and Bootstrap 5. >> README.md
echo ## Installation >> README.md
echo Clone the repository and run the following commands: >> README.md
echo - composer install >> README.md
echo - npm install >> README.md
echo - cp .env.example .env >> README.md
echo - php artisan key:generate >> README.md
echo - npm run dev >> README.md

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^| [8/8] Initializing Git repository                     ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o
echo.

git init
git add .
git commit -m "Initial commit"

echo.
echo o-------------------------------------------------------o
echo ^|                                                       ^|
echo ^|                         Done!                         ^|
echo ^|             Your Laravel project is ready.            ^|
echo ^|                                                       ^|
echo o-------------------------------------------------------o

pause