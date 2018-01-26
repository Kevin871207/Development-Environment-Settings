# Rust
Require `Editor/vscode`, `Compiler/LLVM`,and `Compiler/MinGW` if OS is Windows.
1. [Download](https://static.rust-lang.org/rustup/dist/x86_64-pc-windows-gnu/rustup-init.exe) and run **rustup** initializer.
2. In **rustup** initializer, choose 2 to customize installation and set `default host triple` to `x86_64-pc-windows-gnu` if it is not.
3. In **rustup** initializer, choose 1 to install it.
4. Move all directories about **Rust** to program directory.
  * Windows
    1. Run `cmd.exe` as administrator and run these script:
        ```bash
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
