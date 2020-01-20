# precompile
Supports precompiling binaries for usage on the scrimmage server.

Usage guide:

0. Make sure that you have `docker` installed on your machine for command line usage https://docs.docker.com/install/

Docker on Windows Subsystem for Linux (WSL) requires a special installation (Google is your friend).

Also make sure that you have `make` installed on your command line environment:

```$ make --version```

should not fail.

1. Clone this repository into a convenient working directory.

2. Create a subdirectory named `scrimmage` which contains a working engine game you would like to use to precompile your code.
`scrimmage` should contain `engine.py` and `config.py`, as well as pokerbot(s) to play a game against each other (or the same pokerbot against itself, described in `config.py`).

3. Run

```$ make prebuild```

in this directory. The first run will be very slow in order to download all the dependencies, but subsequent runs will cache the results to speed it up. Alternatively, you may delete dependencies you do not need to speed up the first run.

The above command will create a directory called `built` which contains the prebuilt pokerbot.

Run

```$ make clean```

in this directory to prep the directory for another pokerbot precompilation.

4. Change `commands.json` in the `built` directory to have no build command:

```"build": [],```

5. Zip your pokerbot and upload it to the scrimmage server.
