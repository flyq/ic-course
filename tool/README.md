# tool

## install vessel
1. download from https://github.com/dfinity/vessel/releases
select last version and your computer operation system.
2. open a terminal, run e.g. `sudo chmod 755 vessel-macos`
3. run `./vessel-macos -h`, and will be killed by Mac OS: `[1]    65481 killed     ./vessel-macos -h`
4. open `system preferences` -> `Security & Privacy` -> `Click the lock to make changes` -> something like `Allow vessel-macos anyway` -> `Click the lock to prevent further changes`
5. run 
   ```sh
   ./vessel-macos -h
    vessel 0.6.2
    Simple package management for Motoko

    USAGE:
        vessel-macos [OPTIONS] <SUBCOMMAND>

    FLAGS:
        -h, --help       Prints help information
        -V, --version    Prints version information

    OPTIONS:
            --package-set <package-set>    Which file to read the package set from [default: package-set.dhall]

    SUBCOMMANDS:
        bin            Installs the compiler binaries and outputs a path to them
        help           Prints this message or the help of the given subcommand(s)
        init           Sets up the minimal project configuration
        install        Installs all dependencies and prints a human readable summary
        sources        Installs all dependencies and outputs the package flags to be passed on to the Motoko compiler
                    tools
        upgrade-set    Outputs the import and hash for the latest vessel-package-set release
        verify         Verifies that every package in the package set builds successfully
    ```
6. mv ./vessel-macos /usr/local/bin/vessel


## new projects with vessel
1. new project
   ```sh
   dfx new tool
   ```
2. delete all front-end related files and delete front-end related entries in dfx.json
3. init vessel config. this will add two files: package-set.dhall and vessel.dhall
   ```sh
   vessel init
   ```
4. modify vessel.dhall, add `"sha224"`
5. modify dfx.json, add `vessel sources`
   ```json
    "defaults": {
        "build": {
        "packtool": "vessel sources"
        }
    },
    ```
6. write the code in src/tool/main.mo, and can use sha224

## build & run
for the issues: https://github.com/dfinity/vessel-package-set/issues/28
need comment out `public type Blob/xxx = Prim.Types.Blob/xxx;` in some base library.

terminal 1:
```sh
sudo dfx start --clean
```
terminal 2:
```sh
sudo dfx canister --no-wallet create tool

sudo dfx build

sudo dfx canister --no-wallet install tool

dfx identity get-principal
ktfx3-4dj7o-f4lqf-gab56-fgkuw-aagt6-jzpkd-o7xzp-f6a3p-nm6wl-wae

dfx ledger account-id
ca5aa2bfed7d6b28723605d870578397f3c65df5c0a8a9de51af7dd5e6c22638


dfx canister --no-wallet call tool principalToAccountText '(principal "
ktfx3-4dj7o-f4lqf-gab56-fgkuw-aagt6-jzpkd-o7xzp-f6a3p-nm6wl-wae")'
("ca5aa2bfed7d6b28723605d870578397f3c65df5c0a8a9de51af7dd5e6c22638")
```

