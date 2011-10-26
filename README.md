# FRC Static Jade Challenge

## Jadify: Down and Dirty Static Jade Includes

[James](http://github.com/totheleftpanda) and I started talking about the best way to build a semi-static HTML file (or a PHP file) with lots of repetitive parts. Aside from doing includes on the server-side, you could also compile them client-side.

After talking about how this would work, we challenged one another to research and build a working prototype in under an hour. I decided to use Ruby, and I beat James by a few minutes. The code is ugly as sin, and probably really buggy, but it works.

## How It Works

Jadify takes HTML with comments like `<!-- @jade fileName -->`, finds the filename they refer to, compiles that file, and inserts it as HTML below the comment.

It can also theoretically work with any other template processor that operates via pipe. I haven't tested it with any, but if you used a comment like `<!-- @haml fileName -->`, it would try piping `fileName.haml` through the `haml` executable.

### Don't use this in production

Jadify blindly runs whatever comes after the @ sign and feeds a file to it. This could be extremely bad.
