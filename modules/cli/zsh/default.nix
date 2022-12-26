{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.zsh;
in {
    options.modules.zsh = { enable = mkEnableOption "zsh"; };

    config = mkIf cfg.enable {
    	home.packages = [
	    pkgs.zsh
	];


    programs={
        #-----eXA
         exa.enable = true;
        #-----zoxide
        zoxide = {
            enable = true;
            enableZshIntegration = true;
        };
        #-----dircolors
        dircolors = {
            enable = true;
            enableZshIntegration = true;
        };
        #-----starship
        starship = {
            enable = true;
            settings = {
                add_newline = false;
                scan_timeout = 5;
                character = {
                error_symbol = "[](bold red)";
                success_symbol = "[](bold green)";
                vicmd_symbol = "[](bold yellow)";
                format = "$symbol [|](bold bright-black) ";
                };
                git_commit = {commit_hash_length = 4;};
                line_break.disabled = false;
                lua.symbol = "[](blue) ";
                python.symbol = "[](blue) ";
                hostname = {
                ssh_only = true;
                format = "[$hostname](bold blue) ";
                disabled = false;
                };
            };
            };

        #-----ZSH
        zsh = {
            enable = true;

            # directory to put config files in
            dotDir = ".config/zsh";
            enableCompletion = true;
            enableAutosuggestions = true;
            enableSyntaxHighlighting = true;


            completionInit = ''
                autoload -U compinit
                zstyle ':completion:*' menu select
                zmodload zsh/complist
                compinit
                _comp_options+=(globdots)
                bindkey -M menuselect 'h' vi-backward-char
                bindkey -M menuselect 'k' vi-up-line-or-history
                bindkey -M menuselect 'l' vi-forward-char
                bindkey -M menuselect 'j' vi-down-line-or-history
                bindkey -v '^?' backward-delete-char
                bindkey '^ ' autosuggest-accept
            '';
# PROMPT="%F{blue}%m %~%b "$'\n'"%(?.%F{green}%Bλ%b |.%F{red}?) %f"

            # .zshrc
            initExtra = ''
               
                export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store";
                export ZK_NOTEBOOK_DIR="~/stuff/notes";
                export DIRENV_LOG_FORMAT="";
                
                autoload -U url-quote-magic
                zle -N self-insert url-quote-magic
                export FZF_DEFAULT_OPTS="
                --color fg:#c6d0f5
                --color fg+:#51576d
                --color bg:#303446
                --color bg+:#303446
                --color hl:#8caaee
                --color hl+:#8caaee
                --color info:#626880
                --color prompt:#a6d189
                --color spinner:#8caaee
                --color pointer:#8caaee
                --color marker:#8caaee
                --color border:#626880
                --color header:#8caaee
                --prompt ' | '
                --pointer ''
                --layout=reverse
                --border horizontal
                --height 40
                "

                function run() {
                nix run nixpkgs#$@
                }

                command_not_found_handler() {
                printf 'Command not found ->\033[01;32m %s\033[0m \n' "$0" >&2
                return 127
                }

                clear

                edir() { tar -cz $1 | age -p > $1.tar.gz.age && rm -rf $1 &>/dev/null && echo "$1 encrypted" }
                ddir() { age -d $1 | tar -xz && rm -rf $1 &>/dev/null && echo "$1 decrypted" }
            '';

            # basically aliases for directories: 
            # `cd ~dots` will cd into ~/.config/nixos
            dirHashes = {
                dots = "$HOME/.config/nixos";
                stuff = "$HOME/stuff";
                junk = "$HOME/stuff/other";
                docs = "$HOME/docs";
                notes = "$HOME/docs/notes";
                dotfiles = "$HOME/dotfiles";
                dl = "$HOME/download";
                vids = "$HOME/vids";
                music = "$HOME/music";
                media = "/run/media/$USER";
            };

            # Tweak settings for history
            history = {
                save = 1000;
                size = 1000;
                expireDuplicatesFirst = true;
                ignoreDups = true;
                ignoreSpace = true;
                path = "$HOME/.cache/zsh_history";
            };

            # Set some aliases
            shellAliases = {
                rebuild2 = "doas nix-store --verify; pushd ~dotfiles && doas nixos-rebuild switch --flake .# && notify-send \"Done\"&& bat cache --build; popd";
                cleanup = "doas nix-collect-garbage --delete-older-than 7d";
                bloat = "nix path-info -Sh /run/current-system";
                nd = "nix develop -c $SHELL";
        
                rebuild = "doas nixos-rebuild switch --flake $NIXOS_CONFIG_DIR --fast; notify-send 'Rebuild complete\!'";
                cls = "clear";
                cat = "bat --style=plain";
                cat2 = "bat --paging=never --style=plain";
                grep = "ripgrep";
                du = "du-dust";
                ps = "procs";
                
                mkdir = "mkdir -vp";
                rm = "rm -rifv";
                mv = "mv -iv";
                cp = "cp -riv";
                ls = "exa -a --icons";
                ls2 = "exa -h --git --color=auto --group-directories-first -s extension";
                l = "ls -lF --time-style=long-iso";
                la = "exa -lah";
                tree = "exa --tree --icons";
                tree2 = "exa}--tree --icons";

                fcd = "cd $(find -type d | fzf)";
                sc = "sudo systemctl";
                scu = "systemctl --user ";
                http = "python3 -m http.server";
                burn = "pkill -9";
                diff = "diff --color=auto";
                killall = "pkill";

                ".." = "cd ..";
                "..." = "cd ../../";
                "...." = "cd ../../../";
                "....." = "cd ../../../../";
                "......" = "cd ../../../../../";

                g = "git";
                sudo = "doas";
            };

            # Source all plugins, nix-style
            plugins =  with pkgs;[
                {
                    name = "zsh-nix-shell";
                    src = zsh-nix-shell;
                    file = "share/zsh-nix-shell/nix-shell.plugin.zsh";
                }
                {
                    name = "zsh-vi-mode";
                    src = zsh-vi-mode;
                    file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
                }
                {
                    name = "zsh-autopair";
                    file = "zsh-autopair.plugin.zsh";
                    src = fetchFromGitHub {
                        owner = "hlissner";
                        repo = "zsh-autopair";
                        rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
                        sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
                };
                }
                
                {
                    name = "auto-ls";
                    src = pkgs.fetchFromGitHub {
                        owner = "notusknot";
                        repo = "auto-ls";
                        rev = "62a176120b9deb81a8efec992d8d6ed99c2bd1a1";
                        sha256 = "08wgs3sj7hy30x03m8j6lxns8r2kpjahb9wr0s0zyzrmr4xwccj0";
                    };
                }
        ];
    };
    };
};
}
