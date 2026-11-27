# arc-django-2: start here

Chipo Django 2 musicdisk for the Acorn Archimedes: ARM assembler (vasm + vlink), QTM music player, released April 2023.

| | |
|---|---|
| GitHub | https://github.com/kieranhj/arc-django-2 (public) |
| Local path | D:\archie\mine\arc-django-2 (moved from OneDrive\Archie\Repos\arc-django-2 on 2026-11-22) |
| Branch | main; other branches: wip/2026-11-tidy, wip/archie-only, wip/archie-special, wip/cube-visualiser, wip/logo-movement, wip/preshift-scroller-font, wip/triple-buffering, wip/vsync-bug-hunt, wip/vsync-event (all also on origin) |
| Last commit | 2023-06-24: Create chipo-django2-screenshot.png |

## What's in here

- `arc-django.asm` entry, `src/`, `lib/`; `data/` (gfx, fonts, `music2/` MODs), `folder/`, `bin/` tools.
- `Makefile.mk` (real build via `make.bat` / `bin\snmake.exe`), `link_script.txt`.

## Build and run

- `make`: builds the `!Django02` folder (`make.bat folder`). Works (2026-11-22). The `bin\*.py` converters were ported to Python 3 on 2026-11-22 (byte-identical output) and `Makefile.mk` runs them with `PYTHON2?=py -3` (override with `PYTHON2=...`).
- Other targets: `make deploy` (to `..\arculator\hostfs\Builds`), `make shrinkler_build` / `make lz4_build` (release builds), `make help`.
- Run `!Django02` in Arculator (`D:\archie\mine\arculator`).

## Local changes

- Untracked: 6 Shrinkler-packed MODs in `data/music2/*.shri` (4mat, coolbeans, maze, punnik-Lies, soda7, virgil-holodash).
- `wip/2026-11-tidy` (pushed): snapshot of those 6 files.
- Old wip branches: wip/archie-only is the same as main; wip/cube-visualiser, wip/logo-movement, wip/triple-buffering have nothing beyond main; wip/archie-special ("F'd up branch."), wip/preshift-scroller-font, wip/vsync-bug-hunt, wip/vsync-event each hold 1 unmerged commit from March 2023.

## Status and next steps

- Released (final scrolltext 2023-04-08). Finished; the wip branches are leftovers.

## See also

- `README.md`; `D:\archie\mine\arc-django` (part 1), `D:\archie\mine\archie-verse` (part 3, branch wip/chipo-django3).
