set TTY1 (tty)
[ "$TTY1" = "/dev/tty1" ] && exec labwc

jump shell fish | source

set cf nuc-arch
set d (date +%a' '%d/%m)
set t (date +%R' '%P)
set n (pacman -Qq | wc -l)
set k (uname -r | awk -F'-' '{print $1}')
set m (df -h / | awk -F' ' '{print $3 "/" $2}' | grep G)
set hide "-I Desktop -I Documents -I Downloads -I Music -I Pictures -I Public -I Templates -I Videos -I tags -I R"
set hidedot "-I .git -I .gitconfig -I .anydesk -I .byobu -I .ssh -I .cert -I .wget-hsts -I .bashrc -I .python_history -I .pythonhist -I .lesshst -I .viminfo -I .cache -I .fonts -I .ipython -I R -I .r -I .pki -I .npm -I .lemminx -I .sonarlint -I .streamlit -I .vscode -I .java -I .local -I .moc -I .config -I .alacritty.yml -I .gnupg -I .wine"

abbr ... ../..
abbr .... ../../..
abbr ..... ../../../..
abbr v vimr
abbr s sudo
abbr c code
abbr d docker
abbr dc docker-compose
abbr dcu docker-compose up -d
abbr dcd docker-compose down
abbr p python
abbr m micromamba
abbr mbin 'micromamba install -c conda-forge -n base'
abbr nv nvidia-smi
abbr st streamlit
abbr rmr 'rm -rf'
abbr fishcf 'vim --remote-tab-silent ~/$cf/config.fish'
abbr gs 'git status'
abbr gitquick 'git add . && git commit -am "." && git push origin master'
abbr atrm 'sudo pacman -Rns (pacman -Qdttq)'
abbr pacin 'sudo pacman -S --needed'
abbr pacrm 'sudo pacman -Rns'
abbr myip 'curl ip.me'
abbr cvat 'docker-compose -f ~/cvat/docker-compose.yml -f ~/cvat/components/serverless/docker-compose.serverless.yml up -d'
abbr win "sudo virsh start 7; remote-viewer spice://localhost:5900 -f"
abbr mntwin "sudo mount /dev/nvme0n1p4 ~/c"
abbr screencap "/usr/lib/xdg-desktop-portal -r & /usr/lib/xdg-desktop-portal-wlr"

abbr nasmount "sudo mount -t nfs 192.168.2.50:/volume1/01_TempData ~/asilla"
abbr nasmount2 "sudo mount -t nfs 192.168.2.50:/volume2/02_SafeData ~/asilla"
abbr nasumount "sudo umount ~/asilla"

alias l="lsd -l $hide"
alias ll="lsd -lA $hide $hidedot"
alias vimr="vim --remote-tab-silent"
alias mocp="mocp -T /usr/share/moc/themes/transparent-background"

function print_center -a width
    set -e argv[1]
    set -l len (string length -- "$argv")
    if test $len -lt $width
        set -l half (math -s 0 "($width / 2)" + "($len / 2)")
        set -l rem (math -s 0 $width - $half)
        printf "%*.*s%*s\n" $half $len "$argv" $rem ' '
    else
        printf "%*.*s\n" $width $width "$argv"
    end
end

function fish_greeting
  set_color red
  print_center 99 Today is $d
  set_color magenta
  cal -n3 | sed  -e :a -e 's/^.\{0,97\}$/ & /;ta'
  set_color blue
  echo \n\t\t\t' '$t' '\t' '$n' '\t' '$m' '\t' '$k' '\n
  set_color yellow
  print_center 98 Hello, I\'m Huy
  print_center 98 Have a nice day!
end

function cdls --on-variable PWD
  l
end

function cl
  rm ~/.bash_history
  rm ~/.python_history
  rm ~/.pythonhist
  rm ~/.sqlite_history
  rm ~/.lesshst
  rm ~/.Rhistory
  rm ~/.viminfo
  rm ~/.mysql_history
  rm ~/.local/share/fish/fish_history
  rm -rf ~/.nv
  rm -rf ~/__pycache__
  rm -rf /tmp/*
  rm -rf (string match --invert ~/.cache/huggingface ~/.cache/*)
  rm -f ~/.config/BraveSoftware/Brave-Browser/Default/History
  rm -rf ~/.config/BraveSoftware/Brave-Browser/Default/Service\ Worker/
  micromamba clean --all
  sudo rm -rf /var/lib/systemd/coredump/
  sudo rm -rf /var/cache/
  sudo pacman -Rns (pacman -Qdttq)
  sudo pacman -Scc
  cd
  clear
  fish
end

function black_bg
    dconf write "/org/gnome/desktop/background/picture-uri" "'file:///home/o/$cf/misc/b.png'"
end

function sfpro
    dconf write "/org/gnome/desktop/interface/font-name" "'SF Pro Display 16'"
end

function listenyt -a url
    youtube-dl -f bestaudio $url -o - 2>/dev/null | ffplay -nodisp -autoexit -i - &>/dev/null
end

function mamall
    echo micromamba install (micromamba env export --from-history -n base | grep -A 100 'es:' | awk '{print $2}' | grep . | sort) -c conda-forge -n base
end

