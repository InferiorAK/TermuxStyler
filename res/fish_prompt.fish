# name: Zish

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
  set_color -o cyan
  printf '┌─<'
  set_color -o green
  printf 'Inferior'
  set_color -o red
  printf 'AK'
  set_color $fish_color_autosuggestion[1]
  printf ' @ '
  set_color $fish_color_autosuggestion[1]
  set_color -o green
  printf '%s' (prompt_pwd)
  set_color -o cyan
  printf '>'

  echo
  set_color -o cyan
  printf '└─'
  set_color yellow
  printf '%s' (__fish_git_prompt)
  if [ (_is_git_dirty) ]
    set_color blue
    printf '* '
  end
  set_color -o cyan
  printf '──'
  set_color red
  printf '>'
  set_color green
  printf '>'
  set_color blue
  printf '⟩'
  set_color yellow
  printf '_ '
  set_color normal
end
