# Rust
Require [Editor/vscode](../Editor/vscode.md), [Compiler/LLVM](../Compiler/LLVM.md),and [Compiler/MinGW](../Compiler/MinGW.md) if OS is Windows and project probably need standard input.
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
      2. Add environment variable `CARGO_HOME` with value `C:\Program Files\Rust\Cargo`.
      3. Add environment variable `RUSTUP_HOME` with value `C:\Program Files\Rust\rustup`.
      4. Change `C:\Users\<user name>\.cargo\bin` to `C:\Program Files\Rust\Cargo\bin` in environment variable `PATH`.
    * UNIX or UNIX-like system
      1. (Unfinished...)
5. Run script `cargo install racer` as administrator or superuser to install **Racer**.
6. Run script `rustup component add rls-preview rust-analysis rust-src` as administrator or superuser to install **Rust Language Server**.
7. Open **Visual Studio Code** and install plugin **Rust (rls)** `rust-lang.rust`.
8. Add these rules to user settings of **Visual Studio Code**:
    ```json
    "rust-client.channel": "stable-x86_64-pc-windows-gnu",
    ```
9. Save these script to start a project conveniently.
    * [create.cmd](Rust/create.cmd) on Windows
    * [create.sh](Rust/create.sh) on UNIX or UNIX-like system (Unfinished...)
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
		        /* Require this if OS is Windows and project probably need standard input */
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
### Note : Reason why should use GDB if OS is Windows and project probably need standard input
**LLDB** is better than **GDB** on debuging **Rust** code, because it does not have problems when argumunts are unicode and variable watcher is more readable than when using **GDB** to debug. But **Visual Studio Code** plugin **LLDB Debugger** `vadimcn.vscode-lldb` seemingly does not support standard input on Windows, so when the project probably need standard input choose **GDB** to debug it.
