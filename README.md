# randomcs.nvim
Random color schemes in NeoVim ✨

## Installation
Using [Lazy.nvim](https://github.com/folke/lazy.nvim)
```
{
    'jdtron/randomcs',
    lazy = false,
    init = function ()
        require('randomcs').setup({
            enabled = true,
            mode = 'weekly',
            default = 'tokyonight-moon',
        })
    end,
}
```

## Configuration
Configuration overview
```
{
    -- Disable random scheme selection. Use with `default` to set a fixed color scheme
    -- Default: true
    enabled = true,                
                                    
    -- Mode to use. Select from: daily, weekly, monthly
    -- Default: 'daily'
    mode = 'weekly',                
                                    
    -- Default color scheme to use, when random selection is disabled
    -- Default: nil
    default = 'tokyonight-moon',    
                                    
    -- Send notification when random scheme is applied
    -- Default: true
    notify = true,                  
},
```

## Register Color Schemes
Set a list of themes on `setup`:
```
require('randomcs').setup({
    enabled = true,
    mode = 'weekly',
    default = 'tokyonight-moon',
}, {
    'tokyonight-moon',
    'onedark',
    'kanagawa',
})
```

Or make the color scheme plugins register themself on init. Example with [Lazy.nvim](https://github.com/folke/lazy.nvim):
```
{
    'folke/tokyonight.nvim',
    init = function ()
        require('randomcs').register('tokyonight-moon')
    end
},
```

## Apply Color Scheme
Call `require('randomcs').apply()` to apply a color scheme.  
This can be done either chained with `setup` or with your own hooks.
```
require('randomcs').setup({ ... }).apply()
```

There are also user commands available:
- `Randomcs`
  Apply a random color scheme (same as `.apply()`)
- `RandomcsDefault`
  Apply the default color scheme
