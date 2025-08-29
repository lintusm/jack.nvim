# Introduction
A Basic Nvim color scheme with little blue color to
further my quest of purging blue light of my system

## light
![light theme](_light-bg.png)

## dark
![dark theme](_dark-bg.png)

# Installation
## Lazy.nvim
```
require('lazy').setup({
    {
      'lintusm/jack.nvim',
      priority = 1000,
    },
})
```
## Manual
1. go to nvim directory's
```
cd $HOME/.config/nvim/lua
```
2. clone this repository
you can delete the README and the .png if you want
```
git clone https://github.com/lintusm/jack.nvim
```
or
```
git clone https://codeberg.org/lintus/jack.nvim
```
3. edit nvim configuration
```
vim ../init.lua
```
and add:
```
require('jack.nvim').setup()
-- vim.o.background = 'light'
```
# Usage
```
-- set color scheme
vim.o.colorscheme = 'jack'
-- set background
vim.o.background = 'dark'
```
