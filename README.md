# Install

## PHP core function docs

For core PHP functions to get picked up the following needs to be run:

   <kbd>M-x load-library RET php-extras-gen-eldoc RET</kbd>

   <kbd>M-x php-extras-generate-eldoc RET</kbd>

Source: https://raw.githubusercontent.com/arnested/php-extras/

## Expand region

Version in MELPA stable doesn't work until Emacs version 25.1

https://github.com/magnars/expand-region.el/issues/160


## Code navigation

I used this as inspiration: http://mattbriggs.net/blog/2012/03/18/awesome-emacs-plugins-ctags/

First `ctags` needs to be installed on the system and from a command
line run something like the following:

    ctags -e -R --extra=+fq src vendor


For sane tag searching use this configuration:

    ;; nil means case-sensitive
    (setq tags-case-fold-search nil)


Navigating back and forth just place the cursor on a method and press
`M-.` to navigate to the definition. The first time navigation is used
it will ask for the location of the TAGS file. To navigate back use
`M-,`. To search for a method or class use `M-?`.

Put ctag configuration that is global across all projects in `.ctags`
file in the home directory. Ie. like ignoring `.git` directories etc.
