# Kusanagi

**Kusanagi** is a real-time collaboration diagramming tool.

## Prerequisites

1. Install [**Erlang**](https://www.erlang.org/) and [**Elixir**](https://elixir-lang.org/) using [**asdf**](https://github.com/asdf-vm/asdf)
    1. Download and extract the latest release from **asdf** [GitHub Releases](https://github.com/asdf-vm/asdf/releases)
        ```bash
        # Create the .asdf directory
        mkdir -p ~/.asdf

        # Download latest release binary archive, currently v0.18.0
        wget -O ~/.asdf/asdf.tar.gz https://github.com/asdf-vm/asdf/releases/download/v0.18.0/asdf-v0.18.0-linux-amd64.tar.gz

        # Extract the binary from the downloaded archive
        tar -xzf ~/.asdf/asdf.tar.gz -C ~/.asdf/
        ```
    1. Add **asdf** to the shell's PATH and reload it
        ```bash
        echo 'export PATH="$HOME/.asdf:$PATH"' >> ~/.bashrc
        source ~/.bashrc
        ```
    1. Install **Erlang** and **Elixir** using **asdf**
        ```bash
        # Add Erlang and Elixir plugins
        asdf plugin add erlang
        asdf plugin add elixir

        # Install project plugin versions
        asdf install erlang 28.2
        asdf install elixir 1.19.4
        ```
    1. Install **Elixir** package manager, [**Hex**](https://hex.pm/)
        ```bash
        # Change directory to backend/
        cd backend

        mix local.hex
        ```
