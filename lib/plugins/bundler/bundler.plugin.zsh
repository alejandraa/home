# Quick aliases for Bundler

alias be="bundle exec"

# Bundle installation tasks come with `ct` alias so CTags are generated
# on the fly.
alias bib="bundle install -j 4"
alias bic="bib && ct"
alias bi=bic

alias bl="bundle list"
alias bp="bundle package"
alias bu="bundle update"
