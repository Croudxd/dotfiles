## Neovim external dependencies

The Neovim config does not install language servers itself. Mason was removed
because it downloads prebuilt binaries that assume an FHS layout — its
rust-analyzer asks for `/lib64/ld-linux-x86-64.so.2`, which does not exist on
NixOS. Every binary is instead resolved from `PATH` by bare name, so
provisioning is the system's job and the Lua config never changes between
distros.

To add a language server: install the binary, then add its `lspconfig` name to
the `vim.lsp.enable` list in `.config/nvim/lua/plugins/lsp.lua`.

### Required

| Tool | Used for | Arch | nixpkgs |
| --- | --- | --- | --- |
| clangd | C++ LSP | `clang` | `clang-tools` |
| lua-language-server | Lua LSP | `lua-language-server` | `lua-language-server` |
| rust-analyzer | Rust LSP | `rustup component add rust-analyzer` | `rust-analyzer` |
| ruff | Python lint + format LSP | `ruff` | `ruff` |
| basedpyright | Python types + navigation | `uv tool install basedpyright` | `basedpyright` |
| gdb | C++ debugging via `nvim-dap` | `gdb` | `gdb` |
| ripgrep | Telescope `live_grep` | `ripgrep` | `ripgrep` |
| fd | Telescope `find_files` | `fd` | `fd` |
| git, curl | lazy.nvim bootstrap and plugin fetch | `git`, `curl` | `git`, `curl` |
| gcc, make | builds LuaSnip's `jsregexp` module | `gcc`, `make` | `gcc`, `gnumake` |
| yazi | `yazi.nvim` file manager | `yazi` | `yazi` |

Note that `clangd` ships in `clang` on Arch but in **`clang-tools`** on nixpkgs.

### Optional

| Tool | Used for | Arch | nixpkgs |
| --- | --- | --- | --- |
| just | Overseer `just` task provider | `just` | `just` |
| win32yank | clipboard under WSL | not packaged | not packaged |

### Arch

Everything needed is in the official repositories, so no AUR helper is
required:

```bash
sudo pacman -S clang lua-language-server gdb ripgrep fd git curl gcc make yazi
sudo pacman -S just   # optional
rustup component add rust-analyzer
uv tool install ruff
uv tool install basedpyright
```

`ruff` and `basedpyright` come from `uv` here only because `basedpyright` is not
in the official repositories. On NixOS both should come from nixpkgs instead, so
that nothing is installed imperatively.

### NixOS

Scope the tools to Neovim rather than installing them globally. This is the
closest equivalent to what Mason was doing, except declarative and pinned by the
flake lock:

```nix
programs.neovim = {
  enable = true;
  extraPackages = with pkgs; [
    clang-tools
    lua-language-server
    rust-analyzer
    ruff
    basedpyright
    gdb
    ripgrep
    fd
    yazi
    just
  ];
};
```

The nixpkgs attribute names above have not been verified against a nix
installation; confirm each with `nix search nixpkgs <name>` before relying on
them.

### Checking what is missing

```bash
for b in clangd lua-language-server rust-analyzer ruff basedpyright-langserver \
         gdb rg fd yazi just; do
  command -v "$b" >/dev/null || echo "missing: $b"
done
```
