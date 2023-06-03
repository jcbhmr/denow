# Deno wrapper

🦕 Like [`./gradlew`], but for [Deno]

<div align="center">

![](https://i.imgur.com/Mjwuwyg.png)

</div>

🦕 Downloads a pinned version of Deno \
📂 Caches Deno installation in the `.deno` folder \
🌟 Creates a `./denow` wrapper script that auto-downloads Deno \
👤 Users don't need to install `deno` globally

❤️ I'd love any Windows experts to add a `install.ps1` and `./denow.*` for
Windows support!

## Installation

![curl](https://img.shields.io/static/v1?style=for-the-badge&message=curl&color=073551&logo=curl&logoColor=FFFFFF&label=)
![sh](https://img.shields.io/static/v1?style=for-the-badge&message=sh&color=4EAA25&logo=GNU+Bash&logoColor=FFFFFF&label=)

Find your existing Deno project, then run `install.sh`. If you're using Windows,
you can use [Git Bash] to emulate a POSIX shell. 👍

```sh
curl -fsSL https://deno.land/x/deno_wrapper/deno_wrapper.sh | sh
```

You can add a `vN.N.N` argument to download a specific version. By default we
use the `Deno.version.deno` version or else the latest Deno release.

```sh
curl -fsSL https://deno.land/x/deno_wrapper/deno_wrapper.sh | sh -s 1.30.0
```

## Usage

![Terminal](https://img.shields.io/static/v1?style=for-the-badge&message=Terminal&color=4D4D4D&logo=Windows+Terminal&logoColor=FFFFFF&label=)
![Linux](https://img.shields.io/static/v1?style=for-the-badge&message=Linux&color=222222&logo=Linux&logoColor=FCC624&label=)
![macOS](https://img.shields.io/static/v1?style=for-the-badge&message=macOS&color=000000&logo=macOS&logoColor=FFFFFF&label=)

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
inspect the generated `./deno` file to see what version of Deno they are
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

![Bash](https://img.shields.io/static/v1?style=for-the-badge&message=Bash&color=4EAA25&logo=GNU+Bash&logoColor=FFFFFF&label=)
![sh](https://img.shields.io/static/v1?style=for-the-badge&message=sh&color=4EAA25&logo=GNU+Bash&logoColor=FFFFFF&label=)

Most stuff is in POSIX shell code for max compat with macOS and Linux variants
that use different `bash`, `ksh`, `fish`, etc. shells.

Make sure you check the Webhooks tab after each release to make sure that Deno
actually recieved the payload from the Release event!

```sh
WEBHOOK:
Payload URL: https://api.deno.land/webhook/gh/deno_wrapper
Select individual events: "Branch or tag creation"
```

<!-- prettier-ignore-start -->
[Deno]: https://deno.com/runtime
[github will even block files larger than 100mb]: https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github
[Git Bash]: https://gitforwindows.org/
[`./gradlew`]: https://github.com/gradle/gradle/blob/master/gradlew
[The Gradle Wrapper]: https://docs.gradle.org/current/userguide/gradle_wrapper.html
<!-- prettier-ignore-end -->
