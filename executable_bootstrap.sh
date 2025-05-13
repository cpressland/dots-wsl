#!/usr/bin/env bash

function install_essentials() {
    mkdir -p ~/.local/bin
    sudo dnf update -y
    sudo dnf install -y \
        fish \
        wget \
        azure-cli \
        neovim \
        atuin \
        zstd \
        curl \
        jq \
        ncurses \
        git \
        just \
        ripgrep \
        rsync \
        tmux \
        tree \
        watch
}

function install_opentofu() {
    curl -sL $(curl -s https://api.github.com/repos/opentofu/opentofu/releases/latest \
        | jq -r '.assets[] | select(.name | test("_linux_amd64.tar.gz$")) | .browser_download_url') \
        | tar xz -C ~/.local/bin tofu
}

function install_bat() {
    curl -sL $(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest \
        | jq -r '.assets[] | select(.name | test("x86_64-unknown-linux-musl.tar.gz$")) | .browser_download_url') \
        | tar xz -C ~/.local/bin --strip-components=1 bat-v*/bat
}

function install_kubectl() {
    curl -sL "https://dl.k8s.io/$(curl -s https://api.github.com/repos/kubernetes/kubernetes/releases/latest \
        | jq -r .tag_name)/kubernetes-client-linux-amd64.tar.gz" \
        | tar xz -C ~/.local/bin --strip-components=3 kubernetes/client/bin/kubectl
}

function install_helm() {
    curl -sL "https://get.helm.sh/helm-$(curl -s https://api.github.com/repos/helm/helm/releases/latest \
        | jq -r .tag_name)-linux-amd64.tar.gz" \
        | tar xz -C ~/.local/bin --strip-components=1 linux-amd64/helm
}

function install_starship() {
    curl -sL $(curl -s https://api.github.com/repos/starship/starship/releases/latest \
        | jq -r '.assets[] | select(.name | test("-x86_64-unknown-linux-gnu.tar.gz$")) | .browser_download_url') \
        | tar xz -C ~/.local/bin starship
}

function install_uv() {
    curl -sL $(curl -s https://api.github.com/repos/astral-sh/uv/releases/latest \
        | jq -r '.assets[] | select(.name | test("x86_64-unknown-linux-gnu.tar.gz$")) | .browser_download_url') \
        | tar xz -C ~/.local/bin --strip-components=1 uv-x86_64-unknown-linux-gnu/uvx uv-x86_64-unknown-linux-gnu/uv
}

function install_flux() {
    curl -sL $(curl -s https://api.github.com/repos/fluxcd/flux2/releases/latest \
        | jq -r '.assets[] | select(.name | test("linux_amd64.tar.gz$")) | .browser_download_url') \
        | tar xz -C ~/.local/bin flux
}

function install_chezmoi() {
    curl -sL $(curl -s https://api.github.com/repos/twpayne/chezmoi/releases/latest \
        | jq -r '.assets[] | select(.name | test("-linux-amd64$")) | .browser_download_url') -o ~/.local/bin/chezmoi; \
        chmod +x ~/.local/bin/chezmoi
}

function install_eza() {
    curl -sL $(curl -s https://api.github.com/repos/eza-community/eza/releases/latest \
        | jq -r '.assets[] | select(.name | test("x86_64-unknown-linux-gnu.tar.gz")) | .browser_download_url') \
        | tar xz -C ~/.local/bin ./eza
}

function install_kubeseal() {
    curl -sL $(curl -s https://api.github.com/repos/bitnami-labs/sealed-secrets/releases/latest \
        | jq -r '.assets[] | select(.name | test("-linux-amd64.tar.gz$")) | .browser_download_url') \
        | tar xz -C ~/.local/bin kubeseal
}

function install_kustomize() {
    curl -sL $(curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest \
        | jq -r '.assets[] | select(.name | test("linux_amd64.tar.gz$")) | .browser_download_url') \
        | tar xz -C ~/.local/bin kustomize
}

function install_trivy() {
    curl -sL $(curl -s https://api.github.com/repos/aquasecurity/trivy/releases/latest \
        | jq -r '.assets[] | select(.name | test("trivy_.*_Linux-64bit.tar.gz$")) | .browser_download_url') \
        | tar xz -C ~/.local/bin trivy
}

function install_kubelogin() {
    tmpdir=$(mktemp -d)
    curl -sL "$(curl -s https://api.github.com/repos/Azure/kubelogin/releases/latest \
        | jq -r '.assets[] | select(.name | test("linux-amd64.zip$")) | .browser_download_url')" \
        -o "$tmpdir/kubelogin.zip"
    unzip -q "$tmpdir/kubelogin.zip" -d "$tmpdir"
    mv "$tmpdir/bin/linux_amd64/kubelogin" ~/.local/bin/
    chmod +x ~/.local/bin/kubelogin
    rm -rf "$tmpdir"
}

function install_fish() {
    sudo chsh -s /usr/sbin/fish cpressland
}

install_essentials
install_opentofu
install_kubectl
install_starship
install_uv
install_flux
install_chezmoi
install_eza
install_kubeseal
install_kustomize
install_trivy
install_helm
install_bat
install_kubelogin
install_fish
