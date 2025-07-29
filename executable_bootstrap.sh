#!/usr/bin/env bash

function log() {
    echo -e "$(date -u) - $1"
}

function install_github_cli() {
    sudo dnf install dnf5-plugins
    sudo dnf config-manager addrepo --from-repofile=https://cli.github.com/packages/rpm/gh-cli.repo
    sudo dnf install gh --repo gh-cli
}

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
        yq \
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
    gh release download --repo opentofu/opentofu --pattern '*_linux_amd64.tar.gz' -O - \
        | tar xz -C ~/.local/bin tofu
}

function install_terraform() {
    log "Installing Terraform"
    tmpdir=$(mktemp -d)
    terraform_version=$(gh release list --repo hashicorp/terraform --json tagName --jq '.[] | select(.tagName | test("^v1\\.(10|[0-9])\\.[0-9]+$")) | .tagName' | head -1)
    curl -sL "https://releases.hashicorp.com/terraform/${terraform_version:1}/terraform_${terraform_version:1}_linux_amd64.zip" \
        -o "${tmpdir}/terraform.zip"
    unzip -q "${tmpdir}/terraform.zip" -d "${tmpdir}"
    mv "${tmpdir}/terraform" ~/.local/bin/
    rm -rf "$tmpdir"
    log "Installed Terraform $terraform_version"
}

function install_bat() {
    log "Installing Bat"
    gh release download --repo sharkdp/bat --pattern '*x86_64-unknown-linux-gnu.tar.gz' -O - \
        | tar xz -C ~/.local/bin --strip-components=1 bat-v*/bat
    log "Installed Bat"
}

function install_kubectl() {
    log "Installing Kubectl"
    kubectl_version=$(gh release view --repo kubernetes/kubernetes --json tagName --jq .tagName)
    curl -sL "https://dl.k8s.io/${kubectl_version}/kubernetes-client-linux-amd64.tar.gz" \
        | tar xz -C ~/.local/bin --strip-components=3 kubernetes/client/bin/kubectl
    log "Installed Kubectl $kubectl_version"
}

function install_helm() {
    log "Installing Helm"
    helm_version=$(gh release view --repo helm/helm --json tagName --jq .tagName)
    curl -sL "https://get.helm.sh/helm-${helm_version}-linux-amd64.tar.gz" \
        | tar xz -C ~/.local/bin --strip-components=1 linux-amd64/helm
    log "Installed Helm $helm_version"
}

function install_starship() {
    log "Installing Starship"
    gh release download --repo starship/starship --pattern '*-x86_64-unknown-linux-gnu.tar.gz' -O - \
        | tar xz -C ~/.local/bin starship
}

function install_uv() {
    log "Installing uv"
    gh release download --repo astral-sh/uv --pattern '*x86_64-unknown-linux-gnu.tar.gz' -O - \
        | tar xz -C ~/.local/bin --strip-components=1 uv-x86_64-unknown-linux-gnu/uvx uv-x86_64-unknown-linux-gnu/uv
}

function install_flux() {
    log "Installing Flux"
    gh release download --repo fluxcd/flux2 --pattern '*_linux_amd64.tar.gz' -O - \
        | tar xz -C ~/.local/bin flux
}

function install_chezmoi() {
    log "Installing Chezmoi"
    gh release download --repo twpayne/chezmoi --pattern '*-linux-amd64' --clobber -O ~/.local/bin/chezmoi \
        | chmod +x ~/.local/bin/chezmoi
}

function install_eza() {
    log "Installing Eza"
    gh release download --repo eza-community/eza --pattern '*x86_64-unknown-linux-gnu.tar.gz' -O - \
        | tar xz -C ~/.local/bin ./eza
}

function install_kubeseal() {
    log "Installing Kubeseal"
    gh release download --repo bitnami-labs/sealed-secrets --pattern '*-linux-amd64.tar.gz' -O - \
        | tar xz -C ~/.local/bin kubeseal
}

function install_kustomize() {
    log "Installing Kustomize"
    gh release download --repo kubernetes-sigs/kustomize --pattern '*_linux_amd64.tar.gz' -O - \
        | tar xz -C ~/.local/bin kustomize
}

function install_trivy() {
    log "Installing Trivy"
    gh release download --repo aquasecurity/trivy --pattern '*_Linux-64bit.tar.gz' -O - \
        | tar xz -C ~/.local/bin trivy
}

function install_kubelogin() {
    log "Installing Kubelogin"
    tmpdir=$(mktemp -d)
    gh release download --repo Azure/kubelogin --pattern '*-linux-amd64.zip' -O "$tmpdir/kubelogin.zip"
    unzip -q "$tmpdir/kubelogin.zip" -d "$tmpdir"
    mv "$tmpdir/bin/linux_amd64/kubelogin" ~/.local/bin/
    chmod +x ~/.local/bin/kubelogin
    rm -rf "$tmpdir"
}

function install_fish() {
    sudo chsh -s /usr/sbin/fish cpressland
}

if ! command -v gh &> /dev/null; then
    echo "GitHub CLI not found. Installing..."
    install_github_cli
    echo "Install Complete, re-run script after logging in."
    exit 0
fi

install_essentials
install_opentofu
install_terraform
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
