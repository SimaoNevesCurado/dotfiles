# Helix

Language servers for PHP (Intelephense), Laravel (official Laravel LSP), Rust,
JavaScript, TypeScript, and Vue. Vue formatting uses Prettier.

## Dependencies

With Node.js/npm, PHP/Composer, and Rust/rustup installed:

```bash
npm install -g intelephense typescript@5.9 typescript-language-server @vue/typescript-plugin prettier
composer global require laravel/lsp
rustup component add rust-analyzer
```

Keep npm's global bin directory, Composer's global bin directory, and
`~/.cargo/bin` on `PATH`. TypeScript 5.9 supplies the `tsserver` needed by
`typescript-language-server`; the TypeScript 7 installation tested did not.
No Go installation is needed.

## Restore

Copy `languages.toml` to `~/.config/helix/languages.toml`. Before using it on
another machine, update the Vue plugin `location` to the output of
`npm root -g` followed by `/@vue/typescript-plugin`. The checked-in path uses
this machine's mise Node `latest` directory.

Restart Helix and open a file in the project. Laravel LSP requires a Laravel
project root with an `artisan` file.

Check installation with `helix --health php`, `helix --health rust`,
`helix --health vue`, `helix --health javascript`, and
`helix --health typescript`. Some systems name the executable `hx`.
