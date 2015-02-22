export LC_CTYPE=en_US.UTF-8

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export SAMBAMBA_BIN_DIR=/home/streit/Work/Sambamba/build
export CPLEX_HOME=/home/streit/Utils/CPLEX/
export GUROBI_HOME=/opt/gurobi

if [[ `uname` == 'Darwin' ]]; then
  export JAVA_HOME=`/usr/libexec/java_home -v 1.7`
  export PATH=/opt/local/bin:/opt/local/sbin:$JAVA_HOME/bin:/Users/streit/Library/Haskell/bin:/opt/local/libexec/gnubin/:/usr/local/bin:/usr/texbin:/usr/bin:/bin:/usr/sbin:/sbin
  export CPLUS_INCLUDE_PATH=/opt/local/include:/opt/local/libexec/llvm-3.4/lib/c++/v1:/opt/local/include/gcc48/c++:/opt/local/include/gcc48/c++/x86_64-apple-darwin13
  export C_INCLUDE_PATH=/opt/local/include
else
  export LD_LIBRARY_PATH=$SAMBAMBA_BIN_DIR/Debug+Asserts/lib:$SAMBAMBA_BIN_DIR/Release+Asserts/lib:$SAMBAMBA_BIN_DIR/Debug+Asserts+ASan/lib:/usr/local/lib:~/Utils/tbb/lib/intel64/gcc4.4:~/Work/Cloog+ISL/install/lib:$GUROBI_HOME/lib
  export PATH=/bin:/usr/local/sbin/:/usr/local/bin:/usr/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:$GUROBI_HOME/bin
  export FBFONT=/usr/share/kbd/consolefonts/ter-216n.psf.gz
  export PKG_CONFIG_PATH=/usr/lib/pkgconfig 
fi

path=(
  ~/Games/bin
  ~/Utils/bin
  ~/.dotfiles/utils/bin
  ~/.cabal/bin
  /usr/local/{bin,sbin}
  $path
  ~/Work/Sambamba/build/{Release,Debug}+Asserts/bin
)

if which cope_path >/dev/null 2>&1; then
  path=(
    $(cope_path)
    $path
  )
fi

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

export LANG='en_US.UTF-8'
export EDITOR='vim'
export VISUAL='vim'
export PAGER='vimpager'
