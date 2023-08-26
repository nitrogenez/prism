<img src="common/assets/Prism_Banner.svg"/>

![Build Status][proj-build-status]
![License][proj-license]
![Language][proj-lang]

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

> **NOTE**  
> Prism is still under active development.  
> Please, raise an issue, if you encounter any bugs.

# Why Prism?
Prism is lightweight, fast, and easy to use in general. There is no boilerplate, just import the library, and start using colors and convert them into any of supported colorspaces, including CIE l\*a\*b\*, which is a highly useful colorspace for working with colors that our eyes actually percept.

# Usage
To use Prism you must have the source code in your project. You can either clone it, or download as an archive.  

To then use it in your project, add the following to your project's `build.zig`:

```zig
const prism = b.createModule(.{
    .source_file = .{ .path = "/path/to/prism.zig"},
});

your_exe_or_lib.addModule("prism", prism);
```

# Building
To build Prism as a standalone library you must need Zig 0.11.0. Then just go into the Prism project root via `cd`, and then use `zig build` to build Prism. Use `zig test src/tests.zig` to run tests.

# Contributing
All the files must be formatted and linted with `zig fmt`. The code must be consistent and clean. If needed, use `// zig fmt: off` and `// zig fmt: on` comments.

If you are willing to make Prism better (or worse), you may follow the instructions:

1. [Fork Prism](https://github.com/nitrogenez/prism/fork)
2. Create a new branch using git, e.g `git checkout -b feat/myfeat`
3. Write your dream code
4. Add your changes and make a commit:
   + `git add src/prism.zig`
   + `git commit -m "me make code"`
5. [Open a merge request](https://github.com/nitrogenez/prism/compare)
6. Wait for any contributor to review your code
7. Go get some tea, because the review may take a while
8. Make changes if requested by a reviewer as described previousely
9. You're GTG, enjoy your profile pic in a contributors list :)

# Colorspace Support
| NAME | STATE       |
| ---- | ----------- |
| CMYK | **FULL**    |
| HSI  | **PARTIAL** |
| HSL  | **FULL**    |
| LAB  | **FULL**    |
| YIQ  | **PARITAL** |
| HSV  | **FULL**    |
| RGB  | **FULL**    |
| XYZ  | **FULL**    |

### Meaning
+ **NAME** - Name of the colorspace
+ **STATE** - A colorspace support state
  + **FULL** - A full-featured colorspace support
  + **PARTIAL** - It kinda works, but is lacking functionality

# License
Prism is licensed under a **BSD-3-Clause "New" or "Revised" License**. See [LICENSE](LICENSE) to learn more.


[proj-lang]: https://img.shields.io/badge/_-pure_zig-blue?style=flat-square&logo=zig&logoColor=white&labelColor=1f2335&color=7dcfff
[proj-license]: https://img.shields.io/github/license/nitrogenez/prism?style=flat-square&logo=freebsd&labelColor=1f2335&color=7dcfff
[proj-build-status]: https://img.shields.io/github/actions/workflow/status/nitrogenez/prism/ci.yml?style=flat-square&logo=github&labelColor=1f2335