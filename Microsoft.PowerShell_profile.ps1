Set-Location ~

if ($env:NVIM_LISTEN_ADDRESS) {
    Set-Alias -Name vim -Value {nvim --listen /tmp/nvim-server.pipe}
}

# common typo alias 
Set-Alias -Name "camke" -Value "cmake"
Set-Alias -Name "lzg" -Value "lazygit"

function prompt {
  $loc = $executionContext.SessionState.Path.CurrentLocation;

  $out = ""
  if ($loc.Provider.Name -eq "FileSystem") {
    $out += "$([char]27)]9;9;`"$($loc.ProviderPath)`"$([char]27)\"
  }
  $out += "PS $loc$('>' * ($nestedPromptLevel + 1)) ";
  return $out
}

oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_rainbow.omp.json" | Invoke-Expression
