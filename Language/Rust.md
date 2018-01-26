# Rust
Require [Editor/vscode](../Editor/vscode.md), [Compiler/LLVM](../Compiler/LLVM.md),and [Compiler/MinGW](../Compiler/MinGW.md) if OS is Windows.
## Install and config
1. [Download](https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-gnu/rustup-init.exe) and run **rustup** initializer.
2. In **rustup** initializer, choose 2 to customize installation and set `default host triple` to `x86_64-pc-windows-gnu` if it is not.
3. In **rustup** initializer, choose 1 to install it.
4. Move all directories about **Rust** to program directory.
  * Windows
    1. Run `cmd.exe` as administrator and run these script:
        ```cmd
        md "C:\Program Files\Rust\"
        move "C:\Users\<user name>\.cargo" "C:\Program Files\Rust\Cargo"
        move "C:\Users\<user name>\.rustup" "C:\Program Files\Rust\rustup"
        ```
    2. Add `C:\Program Files\Rust\Cargo` to environment variable `CARGO_HOME`.
    3. Add `C:\Program Files\Rust\rustup` to environment variable `RUSTUP_HOME`.
    3. Change `C:\Users\<user name>\.cargo\bin` to `C:\Program Files\Rust\Cargo\bin` in environment variable `PATH`.
  * UNIX and UNIX-like system
    1. (Unfinished...)
5. Run script `cargo install racer` as administrator or superuser to install **Racer**.
6. Run script `rustup component add rls-preview rust-analysis rust-src` as administrator or superuser to install **Rust Language Server**.
7. Open **Visual Studio Code** and install plugin **Rust (rls)** `rust-lang.rust`.
8. Add these rules to user settings of **Visual Studio Code**:
    ```json
    "rust-client.channel": "stable-x86_64-pc-windows-gnu",
    ```
9. Save this script to start a project conveniently.
  * Windows
    
    Named `create.cmd`
    ```cmd
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
    ```
  * UNIX and UNIX-like system
    
    Named `create.sh`
    
    (Unfinished...)
    
## Start a project
1. Open `create.cmd` or `create.sh` and input project name to create a project.
2. Open the project directory with **Visual Studio Code**.
3. Setting `tasks.json` in **Visual Studio Code**:
    ```json
    {
    	"version": "2.0.0",
    	"tasks": [
    		{
    			"type": "shell",
    			"label": "cargo build",
    			"command": "cargo",
    			"args": [
    				"build"
    			],
    			"problemMatcher": [
    				"$rustc"
    			]
    		}
    	]
    }
    ```
5. Setting `launch.json` in **Visual Studio Code**:
    ```json
    {
    	"version": "0.2.0",
    	"configurations": [
    		{
    			"name": "Debug on LLDB",
    			"type": "lldb",
    			"request": "launch",
    			"program": ".\\target\\debug\\${workspaceFolderBasename}.exe",
    			"cwd": "${workspaceRoot}",
    			"preLaunchTask": "cargo build"
    		},
		        /* Require this if OS is Windows */
    		{
    			"name": "Debug on GDB",
    			"type": "gdb",
    			"request": "launch",
    			"target": ".\\target\\debug\\${workspaceFolderBasename}.exe",
    			"cwd": "${workspaceRoot}",
    			"preLaunchTask": "cargo build",
    			"terminal": ""
    		}
    	]
    }
    ```
    
