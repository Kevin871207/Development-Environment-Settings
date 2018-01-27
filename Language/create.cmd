@echo off
chcp 65001
cls

:name
set /p name="Project Name  : "
:exec
set /p exec="Is Executable : (y|n) "

if "%exec%" == "Y" ( set "exec=y" )
if "%exec%" == "N" ( set "exec=n" )
if "%exec%" == "y" ( set "exec=--bin" ) else ( if "%exec%" == "n" ( set "exec=" ) else ( goto exec ) )

if exist %name% (
	( dir /b /a "%name%" | findstr . ) > nul && (
		echo Warning : "%name%" folder exists and not empty.
		goto init
	) || (
		:cargo_init
		if exist %name%\Cargo.toml (
			echo del /q /f .\%name%\Cargo.toml
			del /q /f .\%name%\Cargo.toml
		)
		echo cargo init %name%
		cargo init %name%
		goto end
	)
) else (
	echo cargo new %name% %exec%
	cargo new %name% %exec%
	goto end
)

:init
set /p init="Is Initialize : (y|n) "
if "%init%" == "Y" ( set "init=y" )
if "%init%" == "N" ( set "init=n" )
if "%init%" == "y" ( goto cargo_init ) else ( if "%init%" == "n" ( goto name ) else ( goto init ) )

:end
if %errorlevel% neq 0 ( goto name )

PAUSE