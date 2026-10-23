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

## DevOps and Linux configuration

The configuration extends Helix 25.07.1's built-in language definitions and
keeps their file detection, shebangs, roots, and server commands.

| Files | Language server | Features |
| --- | --- | --- |
| YAML, CI workflows, Kubernetes manifests | yaml-language-server | Completion, validation, formatting, SchemaStore schemas |
| Bash and POSIX sh scripts | bash-language-server | Completion, navigation, ShellCheck diagnostics, shfmt formatting |
| Dockerfile | docker-langserver | Completion and diagnostics |
| Docker Compose | docker-compose-langserver, yaml-language-server | Compose completion and YAML validation |
| JSON | vscode-json-language-server | Completion and validation; Prettier formatting |
| TOML | taplo | Completion, validation, formatting |
| Terraform `.tf` and `.tfvars` | terraform-ls | Terraform language support |

Install the Node.js servers:

```bash
npm install -g yaml-language-server bash-language-server dockerfile-language-server-nodejs @microsoft/compose-language-service vscode-langservers-extracted
```

Install `shellcheck`, `shfmt`, `taplo`, and `terraform-ls` with your package
manager and keep them on `PATH`. Terraform workflows also need the Terraform
CLI and initialized providers for project-specific completion.

Bash formatting uses the language server's shfmt integration, which also
supports `.editorconfig`. ShellCheck detects shell dialects from shebangs;
use `#!/bin/sh` for POSIX scripts or `#!/usr/bin/env bash` for Bash scripts.
YAML uses SchemaStore filename matching. For manifests that need an explicit
schema, add a `# yaml-language-server: $schema=...` directive to the YAML file.
Ansible files receive generic YAML support; Ansible-specific diagnostics need
a separate Ansible language server setup.

INI, systemd units, SSH config, Makefiles, and other formats retain Helix's
built-in support. Do not associate every `.conf` file with one language:
Linux services use different configuration syntaxes.

Check the dependencies after installation:

```bash
for language in yaml bash dockerfile docker-compose json toml hcl tfvars; do
  helix --health "$language"
done
```

Restart Helix after changing `languages.toml`.

References: [Helix language defaults](https://github.com/helix-editor/helix/blob/25.07.1/languages.toml),
[YAML language server](https://github.com/redhat-developer/yaml-language-server),
[Bash language server](https://github.com/bash-lsp/bash-language-server).
