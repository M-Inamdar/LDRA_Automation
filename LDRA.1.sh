@echo off

REM Run JUnit tests
echo Running JUnit tests...
cd /d C:\path\to\java\project
gradlew test
if %errorlevel% neq 0 (
    echo JUnit tests failed.
    exit /b %errorlevel%
)


REM Run Mocha tests
echo Running Mocha tests...
cd /d C:\path\to\javascript\project
npm test
if %errorlevel% neq 0 (
    echo Mocha tests failed.
    exit /b %errorlevel%
)

echo All tests passed successfully.
