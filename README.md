# cisco.nvim

Neovim syntax highlighting for Cisco configuration files.

## Installation

### lazy.nvim

```lua
{
  "splitnines/cisco.nvim",
}
```

### packer.nvim

```lua
use("splitnines/cisco.nvim")
```

## Usage

- Files ending with `*.cisco` are detected automatically.
- Additional content-based detection is included for common switch/router config headers.
- You can always set the filetype manually with `:set filetype=cisco`.

## Testing

Run the lightweight headless Neovim test harness:

```sh
nvim --headless -u tests/minimal_init.lua "+lua require('tests.run').run()" "+qa"
```

## License

[MIT](http://opensource.org/licenses/MIT)
