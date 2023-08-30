Set-location ~


if ($env:NVIM_LISTEN_ADDRESS) {
    Set-Alias -Name vim -Value {nvim --listen /tmp/nvim-server.pipe}
}

