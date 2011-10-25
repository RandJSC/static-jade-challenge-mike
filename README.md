# FRC Static Jade Challenge

## Jadify: Down and Dirty Static Jade Includes

[James](http://github.com/totheleftpanda) and I started talking about the best way to build a semi-static HTML file (or a PHP file) with lots of repetitive parts. Aside from doing includes on the server-side, you could also compile them client-side.

After talking about how this would work, we challenged one another to research and build a working prototype in under an hour. I decided to use Ruby, and I beat James by a few minutes. The code is ugly as sin, and probably really buggy, but it works.

## How It Works

Jadify takes HTML with comments like `<!-- @jade fileName -->`, finds the filename they refer to, compiles that file, and inserts it as HTML below the comment.
