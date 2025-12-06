# Kusanagi

**Kusanagi** is a real-time collaboration diagramming tool.

## Prerequisites

1. Download and extract the latest release from [**asdf**](https://github.com/asdf-vm/asdf) [GitHub Releases](https://github.com/asdf-vm/asdf/releases)
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
    echo 'export PATH="$HOME/.asdf:$HOME/.asdf/shims:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    ```
1. Install build dependencies
    ```bash
    sudo apt install -y unzip build-essential autoconf m4 libncurses5-dev libssl-dev
    ```
1. Install and initialize [**Erlang**](https://www.erlang.org/) and [**Elixir**](https://elixir-lang.org/) using **asdf**
    ```bash
    # Change directory to backend/
    cd backend

    # Add Erlang and Elixir plugins
    asdf plugin add erlang
    asdf plugin add elixir

    # Install project plugin versions
    asdf install

    # Initialize project plugins
    asdf reshim erlang
    asdf reshim elixir
    ```
1. Install **Elixir** package manager, [**Hex**](https://hex.pm/), and fetch dependencies
    ```bash
    # Install Hex package manager
    mix local.hex

    # Fetch dependencies
    mix deps.get
    ```

## Running

Run development build using [**Mix**](https://hexdocs.pm/elixir/main/introduction-to-mix.html) build tool

```shell
mix run --no-halt
```
