# windows-terminal-nvim-config

-Make sure make, clang are installed and added to the path.
-default terminal setting.json file path is in: C:\Users\{UserName}\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState
	- This can be changed via the hard link command to map the file, e.g. "New-Item -ItemType HardLink -Path "C:\Users\{UserData}\AppData\Local\Microsoft\Windows Terminal\settings.json" -Target "C:\tools\windowsterminal\settings.json""


	list of executable to be installed before using full version of nvim config:
		- choco 
			- on windows, install make for building fzf
		- ripgrep for telescope string search
			- in windows: choco install ripgrep
			- in linux: sudo apt install ripgrep

-Use pip install nvr to enable the feature of editing file within lazygit

-Powershell config location is in ~/Document/WindowsPowerShell