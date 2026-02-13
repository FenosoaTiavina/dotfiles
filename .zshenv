if [ -n "${ZSH_VERSION-}" ]; then
  : ${ZDOTDIR:=~/.config/zsh}
fi

source ~/devenv.sh

# Added by Radicle.
export PATH="$PATH:/home/fenosoa/.radicle/bin"

source $HOME/dev/lib/VulkanSDK/setup-env.sh

