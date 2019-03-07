# Coder in Docker

[[Try the Demo](https://labs.play-with-docker.com/?stack=https://gist.githubusercontent.com/sr229/fbb05dfb1e3cb8ec8dc0f9ad8976f40c/raw/8794a85b34c20e873e3c08a4e4cfba8227df9aa5/docker-stack.yml)]

This is a distribution of Coder's [Visual Studio Code in browser](https://github.com/codercom/code-server) designed to work for CNCF-compliant orchestators.

## Running

Simply pull from `chinodesuuu/coder`. 

After the pull has been done, make sure you bound to port 9000 and mount a volume in `/home/coder/projects`.

## Enabling SSL or Auth

to enable auth, make sure you set the environment variable `CODER_ENABLE_AUTH` to true.

to enable SSL, mount your certificates' dir to `/home/coder/certs` and set `CODER_ENABLE_SSL` to true.

Keep in mind for SSL, your files should be named as follows:

- `coder.crt` for the Certificate chain.
- `coder.key` for the Certificate key.

If you didn't name your files as such - it will be invalid and Coder will refuse to work.
