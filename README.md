## Requirements
- Neovim with required options:
  - On OS X:
  ```bash
  pip install neovim
  npm install -g neovim
  gem install neovim
  brew install neovim
  ```

- [Inconsolata for Powerline font](https://github.com/powerline/fonts)
- [Solarized pallete for terminal](http://ethanschoonover.com/solarized)
- For *tagbar*: exuberant-ctags
- For *unite*: [silversearcher-ag](https://github.com/ggreer/the_silver_searcher)
- For *jedi-vim*: jedi (Python package)
- For *autoformat*: astyle, jsbeautifier (Python package)
- For *youcompleteme*: cmake
- For *tern_for_vim*: node.js; npm
- Download [Vim Plug](https://github.com/junegunn/vim-plug)

## Requirements install:
- On RedHat-based Linux:

```bash
sudo yum install ctags cmake nodejs npm

# build astyle
curl -L https://sourceforge.net/projects/astyle/files/astyle/astyle%202.05.1/astyle_2.05.1_linux.tar.gz -O
tar zxvf astyle_2.05.1_linux.tar.gz
rm astyle_2.05.1_linux.tar.gz
cd astyle/build/gcc
make
sudo make install
# cd out

conda install jedi # or pip install jedi
pip install jsbeautifier

# build ag to get the latest version
git clone https://github.com/ggreer/the_silver_searcher
# yum -y groupinstall "Development Tools" # if not already installed
yum -y install pcre-devel xz-devel
cd the_silver_searcher
./build.sh
sudo make install

# on Centos 6, install gcc 4.8.2 from devtoolset-2 to compile YCM
sudo rpm --import http://ftp.scientificlinux.org/linux/scientific/5x/x86_64/RPM-GPG-KEYs/RPM-GPG-KEY-cern
wget -O /etc/yum.repos.d/slc6-devtoolset.repo http://linuxsoft.cern.ch/cern/devtoolset/slc6-devtoolset.repo
sudo yum install devtoolset-2
scl enable devtoolset-2 zsh # or bash
```

## Install
```bash
git clone https://github.com/phphong/dotvim ~/.config/nvim
nvim
```

Then, in Neovim, execute `:PlugInstall`

## Known issues
- sometimes `cl`, `cj`, `ch`, `ck` change 2 chars; `ci"` delete the closing `"`; but `ciw` ok, status bar: `>-` (what?)
- vim signature some times show weird signature
- git gutter airline sometimes not work?
- search history `q/` sometimes show `\s\+$`

## Enhancement ideas

- YCM unicode vietnamese (multibyte problem, YCM supports only single-byte character)
- *unite*: search by register
- *tcomment*: toggle individual lines comment <--> uncomment
- *syntastic*: `lnext` `lprevious` relative to current line
- *syntax*: java custom type, custom identifier highlight
- Open markdown in linux (currently Linux have no app like *Marked 2* on OS X)

## My Vim Cheat Sheet
- https://github.com/phphong/vim-cheat-sheet
