if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

eval "$(~/.rbenv/bin/rbenv init - --no-rehash bash)"

if [ ! -d "$(rbenv root)"/plugins/ruby-build ]; then
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
fi
