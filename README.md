![Build Status][proj-build-status]

# Table of Contents
- [Table of Contents](#table-of-contents)
- [Description](#description)
- [Why Prism?](#why-prism)
- [Usage](#usage)
- [Building](#building)
- [Contributing](#contributing)
- [Colorspace Support](#colorspace-support)
    - [Meaning](#meaning)
- [License](#license)

# Description

Prism is a utility library for managing colors and colorspaces written in Zig.

# Why Prism?
Prism is a lightweight and performant piece of software powered by math. Zig's
comptime optimizations coupled with static typing allows for a huge performance
gain compared to other languages like C++, C#, Java, etc.

# Usage
Prism requires zig `0.14.0-dev.2577+271452d22` to compile.
First, fetch the library into your project using:

```bash
$ zig fetch --save https://github.com/nitrogenez/prism
```

This will fetch the latest commit from the master branch. Next, you should add the following to your build.zig:

```zig
const prism = b.dependency("prism", .{});
my_mod.addImport("prism", prism.module("prism"));
```

# Contributing
All the files must be formatted and linted with `zig fmt`. The code must be
consistent and clean. If needed, use `// zig fmt: off` and `// zig fmt: on`.

If you are willing to make Prism better (or worse),
you may follow the instructions:

1. [Fork Prism](https://github.com/nitrogenez/prism/fork)
2. Create a new branch using git, e.g `git checkout -b feat/myfeat`
3. Write your dream code
4. Add your changes and make a commit:
   + `git add src/my_cool_change.zig`
   + `git commit -m "me code"`
5. [Open a merge request](https://github.com/nitrogenez/prism/compare)
6. Wait for any contributor to review your code
7. Go get some tea, because the review may take a while
8. Make changes if requested by a reviewer as described previousely
9. You're GTG, enjoy your profile pic in a contributors list :)

# Colorspace Support
| NAME | STATE       |
| ---- | ----------- |
| CMYK | **FULL**    |
| HSI  | **FULL**    |
| HSL  | **FULL**    |
| LAB  | **FULL**    |
| YIQ  | **FULL**    |
| HSV  | **FULL**    |
| RGB  | **FULL**    |
| XYZ  | **FULL**    |
| LUV  | **FULL**    |

### Legend
+ **NAME** - Name of the colorspace
+ **STATE** - Colorspace support state
  + **FULL** - A full-featured colorspace support (conversion to and from RGB or anything else)
  + **PARTIAL** - It kinda works, but is lacking functionality (only data type / acknowledged)
  + **NO** - No support at all
  + **TODO** - Planned and is yet to be implemented

# License
Prism is licensed under a 3-clause BSD ("New" or "Revised") License. See [LICENSE](LICENSE) to learn more.

[proj-license]: https://img.shields.io/github/license/nitrogenez/prism?style=flat-square&logo=freebsd&labelColor=1f2335&color=7dcfff
[proj-build-status]: https://img.shields.io/github/actions/workflow/status/nitrogenez/prism/ci.yml?style=flat-square&logo=github&labelColor=1f2335
