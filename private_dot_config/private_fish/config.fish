if status is-interactive
    set -gx EDITOR nvim
    bind \cw backward-kill-word

    function b2k
        for subscription in (az account list --output json 2>/dev/null | jq -r ".[].id")
            az account set --subscription $subscription
            for cluster in (az aks list | jq -r '.[] | "\(.resourceGroup):\(.name)"')
                set cluster_rg (string split ":" $cluster)[1]
                set cluster_name (string split ":" $cluster)[2]
                az aks get-credentials --overwrite-existing --resource-group $cluster_rg --name $cluster_name
            end
        end
        kubelogin convert-kubeconfig -l azurecli
    end

    if type -q chezmoi
	function ccd
	    cd (chezmoi source-path)
        end
    end

    if type -q atuin
        atuin init fish --disable-up-arrow | source
    end

    if type -q eza
        function ls
            eza -F --icons --git --group-directories-first --time-style long-iso --colour-scale all $argv
        end
    end

    if type -q bat
        function cat
            bat --paging=never $argv
        end
    end

    if type -q kubectl
        kubectl completion fish | source
    end

    if type -q flux
        flux completion fish | source
    end

    if type -q starship
        function starship_transient_prompt_func
            starship module character
        end
        starship init fish | source
        enable_transience
    end
end
