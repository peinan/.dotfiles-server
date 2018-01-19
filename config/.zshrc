# PATH
## Default Path
export PATH="$PATH:${HOME}/.local/bin"
export PATH="$PATH:${HOME}/.composer/vendor/bin"
## Dotfile Path
export DOTPATH="${HOME}/.dotfiles"
# Tmux Path
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${HOME}/.local/libevent/lib"

# ALIAS
for f in `ls ${HOME}/.alias.*`; do . $f; done

# OTHERS

## 補完機能の強化
autoload -U compinit

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
## ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

## sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
/usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

## 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
## ここで指定した文字は単語区切りとみなされる
## / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},.|"
zstyle ':zle:*' word-style unspecified

## ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct

## タブによるファイルの順番切り替えをしない
# unsetopt auto_menu

## cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd

## ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd

## 文字化け対策
setopt combining_chars

## ビープを鳴らさない
# setopt nobeep

## 色を使う
setopt prompt_subst

## ^Dでログアウトしない。
setopt ignoreeof

## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

## オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

## '#' 以降をコメントとして扱う
setopt interactive_comments

## = の後はパス名として補完する
setopt magic_equal_subst

## 同時に起動したzshの間でヒストリを共有する
# setopt share_history

## 高機能なワイルドカード展開を使用する
setopt extended_glob


# PROMPT

## Color setting
autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

## Begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
	zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
	zstyle ":vcs_info:git:*" stagedstr "<S>"
	zstyle ":vcs_info:git:*" unstagedstr "<U>"
	zstyle ":vcs_info:git:*" formats "(%b) %c%u"
	zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}

local p_mark="%(!,#,$)"
PROMPT=""
### User
PROMPT+="%{${reset_color}%}[%{${fg[green]}%}%n%{${reset_color}%}"
### Host
PROMPT+="@%{${fg[green]}%}%m%{${reset_color}%}] "
### Directory
# PROMPT+="%{${fg[cyan]}%}%1~"
PROMPT+="%{${fg[cyan]}%}%~"
### Git Info
PROMPT+="\$(vcs_prompt_info)"
### point mark
PROMPT+="
%{${reset_color}%}$p_mark "
### Right Prompt: Date & Time
RPROMPT="%{${fg[blue]}%}[%D %*]%{${reset_color}%}"


# PYENV
if [ -e ${HOME}/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi


# SCREENFETCH
if type screenfetch > /dev/null 2>&1; then
  screenfetch
fi

# Zplug Setting

## Install Script
function install_zplug() {
  # check https://github.com/zplug/zplug
  curl -sL https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
}

## Activate zplug
function activate_zplug() {
  if [[ -s "$HOME/.zplug/init.zsh" ]]; then
    source ~/.zplug/init.zsh

    ## Plugins
    ### auto suggestions
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-completions"
    zplug "zsh-users/zsh-history-substring-search"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2

    ## Install Plugins
    if ! zplug check --verbose; then
        printf 'Install? [y/N]: '
        if read -q; then
            echo; zplug install
        fi
    fi

    ## Load Plugins
    zplug load

  else
    install_zplug
    activate_zplug
  fi
}

activate_zplug
