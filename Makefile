# Wrapper so that `make` works from PowerShell / Windows Terminal.
# GNU make runs recipes with cmd.exe here (no sh on PATH).
# The real build is Makefile.mk, run by bin\snmake.exe via make.bat.
# Note: Makefile.mk converts assets with Python 3 (variable PYTHON2, default "py -3"; scripts ported 2026-11-22).
.PHONY: all build deploy lz4_build shrinkler_build help
all: build

build:
	cmd /c .\make.bat folder

deploy:
	cmd /c .\make.bat deploy

lz4_build shrinkler_build:
	cmd /c .\make.bat $@

help:
	@echo make                  - build the !Django02 RISC OS folder in the repo (make.bat folder)
	@echo make deploy           - build and copy !Django02 to ..\arculator\hostfs\Builds (make.bat's default)
	@echo make shrinkler_build  - release build with a Shrinkler-packed demo, deployed to hostfs
	@echo make lz4_build        - same with LZ4
	@echo make help             - this list
