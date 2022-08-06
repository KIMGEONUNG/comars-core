## Overview

This is a custom snippets collection with vs\_code style.

 
## HOW TO WORK

The *package.json* file must be required and includes what kind of programming
language is associated with which json configuration file. 


```
require("luasnip.loaders.from_vscode").load({ paths = { "./my-snippets" } })
```
