#!/usr/bin/env bash

require_root() {
    if [[ "$EUID" -ne 0 ]]; then
        echo "This script must be run as root. Please rerun with 'sudo'."
        exit 1
    fi
}

function install_wsl_vpnkit() {
    mkdir -p /opt/vpnkit
    tmpdir=$(mktemp -d)
    curl -sL "https://github.com/sakai135/wsl-vpnkit/releases/download/v0.4.1/wsl-vpnkit.tar.gz" \
        -o "${tmpdir}/vpnkit.tar.gz"
    tar -C /opt/vpnkit -xvf ${tmpdir}/vpnkit.tar.gz --strip-components=1 app/
    sed -i 's|^ExecStart=/mnt/c/Windows/system32/wsl.exe -d wsl-vpnkit --cd /app wsl-vpnkit|#&|' /opt/vpnkit/wsl-vpnkit.service
    sed -i 's|^#ExecStart=/full/path/to/wsl-vpnkit|ExecStart=/opt/vpnkit/wsl-vpnkit|' /opt/vpnkit/wsl-vpnkit.service
    sed -i 's|^#Environment=VMEXEC_PATH=/full/path/to/wsl-vm GVPROXY_PATH=/full/path/to/wsl-gvproxy.exe|Environment=VMEXEC_PATH=/opt/vpnkit/wsl-vm GVPROXY_PATH=/opt/vpnkit/wsl-gvproxy.exe|' /opt/vpnkit/wsl-vpnkit.service
    cp /opt/vpnkit/wsl-vpnkit.service /etc/systemd/system/
    systemctl daemon-reload
    systemctl enable wsl-vpnkit.service --now
}

require_root
install_wsl_vpnkit
