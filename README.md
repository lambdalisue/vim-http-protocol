# http-protocol.vim

Allow opening a remote file with `http://` or `https://` format.

Note that this plugin conflicts with `netrw.vim`.

## Supported formats

- `http://...`
- `https://...`

## Requirements

One of the following commands must be available in your system.

- `curl`
- `wget`
- `pwsh` (PowerShell)
- `powershell` (PowerShell)

## Usage

Users must disable `netrw.vim` to use this plugin.

```vim
let g:loaded_netrw = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
```

Then open a remote file with `http://` or `https://` format.

```vim
:e http://example.com
```

## See also

- [file-protocol.vim](https://github.com/lambdalisue/file-protocol.vim) - Allow opening a local file with `file://` format.

# License

The code in fern.vim follows MIT license texted in [LICENSE](./LICENSE).
Contributors need to agree that any modifications sent in this repository follow the license.
