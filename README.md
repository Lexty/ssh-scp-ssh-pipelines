# SSH SCP SSH Pipelines

Fork of [cross-the-world/ssh-scp-ssh-pipelines](https://github.com/cross-the-world/ssh-scp-ssh-pipelines) with bidirectional SCP support.

[Github actions](https://help.github.com/en/actions/creating-actions/creating-a-docker-container-action)

[SSH action](https://github.com/cross-the-world/ssh-pipeline)

[SCP action](https://github.com/cross-the-world/scp-pipeline)

This action allows doing in order
1. ssh if defined
2. scp upload if defined
3. scp download if defined
4. ssh if defined

## Inputs
see the [action.yml](./action.yml) file for more detail imformation.

### `host`

**Required** ssh remote host.

### `port`

**NOT Required** ssh remote port. Default 22

### `user`

**Required** ssh remote user.

### `pass`

**NOT Required** ssh remote pass.

### `key`

**NOT Required** ssh remote key as string.

### `connect_timeout`

**NOT Required** connection timeout to remote host. Default 30s

### `first_ssh`

**NOT Required** execute pre-commands before scp.

### `scp`

**NOT Required** scp from local to remote (upload).

**Syntax**
local_path => remote_path
e.g.
/opt/test/* => /home/github/test

### `scp_download`

**NOT Required** scp from remote to local (download).

**Syntax**
remote_path => local_path
e.g.
/home/github/test/* => ./downloaded/

### `last_ssh`

**NOT Required** execute pre-commands after scp.


## Usages
see the [deploy.yml](./.github/workflows/deploy.yml) file for more detail imformation.

#### ssh scp ssh pipelines with download
```yaml
- name: ssh scp ssh pipelines with download
  uses: Lexty/ssh-scp-ssh-pipelines@v1.2.0
  env:
    WELCOME: "ssh scp ssh pipelines"
    LASTSSH: "Doing something after copying"
  with:
    host: ${{ secrets.DC_HOST }}
    user: ${{ secrets.DC_USER }}
    pass: ${{ secrets.DC_PASS }}
    port: ${{ secrets.DC_PORT }}
    connect_timeout: 10s
    first_ssh: |
      rm -rf /home/github/test
      ls -la \necho $WELCOME 
      mkdir -p /home/github/test/test1 && 
      mkdir -p /home/github/test/test2 &&
    scp: |
      './test/*' => /home/github/test/
      ./test/test1* => /home/github/test/test1/
      ./test/test*.csv => "/home/github/test/test2/"
    scp_download: |
      /home/github/test/logs/* => ./downloaded/logs/
      /home/github/test/output.txt => ./downloaded/
    last_ssh: |
      echo $LASTSSH && 
      (mkdir test1/test || true)
      || ls -la
```

#### scp download pipeline
```yaml
- name: scp download pipeline
  uses: Lexty/ssh-scp-ssh-pipelines@v1.2.0
  with:
    host: ${{ secrets.DC_HOST }}
    user: ${{ secrets.DC_USER }}
    pass: ${{ secrets.DC_PASS }}
    scp_download: |
      /home/github/test/logs/* => ./downloaded/logs/
      /home/github/test/output.txt => ./downloaded/
```

#### scp upload and download pipelines
```yaml
- name: scp upload and download pipelines
  uses: Lexty/ssh-scp-ssh-pipelines@v1.2.0
  with:
    host: ${{ secrets.DC_HOST }}
    user: ${{ secrets.DC_USER }}
    pass: ${{ secrets.DC_PASS }}
    scp: |
      './test/*' => /home/github/test/
    scp_download: |
      /home/github/test/logs/* => ./downloaded/logs/
```

# Changelog

### v1.2.0
- Added bidirectional SCP support with new `scp_download` parameter
- Updated workflow pipeline to support file download from remote server
- Improved documentation with examples for download functionality
- Renamed original `scp_process` function to `scp_upload_process` for clarity

### v1.1.0
- Original version from cross-the-world/ssh-scp-ssh-pipelines

# About this fork

This fork adds the ability to download files from the remote server to the local machine, completing the bidirectional file transfer capabilities of the original action. The original action only supported uploading files to the remote server.

## Contributors

Original author: Scott Ng <thuongnht@gmail.com>
Fork maintainer: Aleksandr Medvedev <alexandr.mdr@gmail.com>

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
