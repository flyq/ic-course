# token

## new a project
1. new a project with dfx
   ```sh
   dfx new token
   ```
2. Option, if not use the front-end, delete all front-end related files.
3. Option, if not use the front-end, delete all front-end related in dfx.
4. modify main.mo and other files.

## build & run
terminal 1:
```sh
sudo dfx start --clean
```
terminal 2:
```sh
sudo dfx canister --no-wallet create token

sudo dfx build

dfx identity get-principal
ktfx3-4dj7o-f4lqf-gab56-fgkuw-aagt6-jzpkd-o7xzp-f6a3p-nm6wl-wae

# need changes the principal to above geted.
sudo dfx canister --no-wallet install token --argumen='("Test Token", "TT", 3, 1_000_000, principal "ktfx3-4dj7o-f4lqf-gab56-fgkuw-aagt6-jzpkd-o7xzp-f6a3p-nm6wl-wae")'


```

