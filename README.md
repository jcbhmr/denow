# Deno wrapper

🦕 Like [`./gradlew`], but for [Deno]

<table align=center><td>

```sh
./denow --help
./denow eval 'console.log(42)'
./denow fmt
./denow task mytask
./denow compile --allow-read --allow-net app.ts
./denow run -A https://examples.deno.land/http-server.ts
```

</table>

🦕 Downloads a pinned version of Deno \
📂 Caches Deno installation in the `.deno` folder \
🌟 Creates a `./denow` wrapper script that auto-downloads Deno \
👤 Users don't need to install `deno` globally

## Installation

![curl](https://img.shields.io/static/v1?style=for-the-badge&message=curl&color=073551&logo=curl&logoColor=FFFFFF&label=)
![sh](https://img.shields.io/static/v1?style=for-the-badge&message=sh&color=4EAA25&logo=GNU+Bash&logoColor=FFFFFF&label=)
![PowerShell](https://img.shields.io/static/v1?style=for-the-badge&message=PowerShell&color=5391FE&logo=PowerShell&logoColor=FFFFFF&label=)

```sh
curl -fsSL https://deno.land/x/denow/install.sh | sh
```

```ps1
irm https://deno.land/x/denow/install.ps1 | iex
```

**If you want to install a specific version of Deno** instead of the latest
version you can use an extra argument to choose a specific version. This is the
_version_ (`1.38.0`), not the _tag name_ (`v1.38.0`).

```sh
curl -fsSL https://deno.land/x/denow/install.sh | sh -s 1.38.0
```

```ps1
v="1.38.0"; irm https://deno.land/x/denow/install.ps1 | iex
```

🛑 If you're looking to install Deno globally [check out the Deno website for an
installation guide].

## Usage

![Terminal](https://img.shields.io/static/v1?style=for-the-badge&message=Terminal&color=4D4D4D&logo=Windows+Terminal&logoColor=FFFFFF&label=)
![Linux](https://img.shields.io/static/v1?style=for-the-badge&message=Linux&color=222222&logo=Linux&logoColor=FCC624&label=)
![macOS](https://img.shields.io/static/v1?style=for-the-badge&message=macOS&color=000000&logo=macOS&logoColor=FFFFFF&label=)
![Windows](https://img.shields.io/static/v1?style=for-the-badge&message=Windows&color=0078D4&logo=Windows&logoColor=FFFFFF&label=)

Just use `./denow` as though it were the true `deno` binary! Anyone who clones
your repo won't need to install deno themselves; the `./denow` will auto-install
a local copy into the `.deno` folder.

⚠️ Make sure you add `.deno` to your `.gitignore`! That's where `deno` will be
installed to by the wrapper.

```sh
./denow --help
./denow eval 'console.log(42)'
./denow fmt
./denow task mytask
./denow compile --allow-read --allow-net https://deno.land/std/http/file_server.ts
./denow run --allow-net https://examples.deno.land/http-server.ts
./denow run -A src/index.ts
```

If you want to update the version of Deno that `./denow` downloads and invokes,
you can go through the install steps (above) again to pin to a different
version. Be aware that this will **overwrite** the `./denow` file. You can also
inspect the generated `./denow` file to see what version of Deno they are
invoking and change it manually.

### Why?

💡 Inspired by [The Gradle Wrapper]

Sometimes (not often, but sometimes), you want to have an auto-install wrapper
around a project-critical binary. In a nutshell you gain the following benefits:

- Standardizes a project on a given Deno version, leading to more reliable and
  robust builds.

- Provisioning a new Deno version to different users and execution environment
  (e.g. IDEs or Continuous Integration servers) is as simple as changing the
  Wrapper definition.

For instance, GitHub Actions can be written using Deno, but how do you make sure
`deno` is available on the GitHub Action runner? You can use `./denow` as a
proxy!

### Why not just download the `deno` binary as `./deno`?

Because the Deno binary is >100MB, which is more than most version control
systems want to deal with. [GitHub will even block files larger than 100MB]!

## Development

![Bash](https://img.shields.io/static/v1?style=for-the-badge&message=Bash&color=FCAF58&logo=GNU+Bash&logoColor=000000&label=)
![sh](https://img.shields.io/static/v1?style=for-the-badge&message=sh&color=4EAA25&logo=GNU+Bash&logoColor=FFFFFF&label=)
![cmd](https://img.shields.io/static/v1?style=for-the-badge&message=cmd&color=000000&logo=GNU+Bash&logoColor=FFFFFF&label=)

Make sure that any changes are roughly the same in the `./denow.bat` and
`./deno` wrappers as well as the `install.ps1` and `install.sh` installers.

<!-- prettier-ignore-start -->
[Deno]: https://deno.com/runtime
[github will even block files larger than 100mb]: https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github
[`./gradlew`]: https://github.com/gradle/gradle/blob/master/gradlew
[The Gradle Wrapper]: https://docs.gradle.org/current/userguide/gradle_wrapper.html
[check out the Deno website for an installation guide]: https://docs.deno.com/runtime/manual/getting_started/installation
<!-- prettier-ignore-end -->
