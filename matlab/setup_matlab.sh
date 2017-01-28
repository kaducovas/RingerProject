
# Get sourced script absolute path
if test -n "`$SHELL -c 'echo $ZSH_VERSION'`"; then
  script_place="$(dirname $(readlink -f "$0"))"
	mshell="zsh"
elif test -n "`$SHELL -c 'echo $BASH_VERSION'`"; then
  script_place=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
	mshell="bash"
elif test "$(basename "$SHELL")" = "zsh"; then
  script_place="$(dirname $(readlink -f "$0"))"
	mshell="zsh"
elif test "$(basename "$SHELL")" = "bash"; then
  script_place=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
	mshell="bash"
else
  printf "ERROR: Unsupported shell." >&2 && return 1;
fi

source "$script_place/../root/RootCoreMacros/common_shell_fcns.sh" || { echo "Couldn't load base shell environment." && return exit 1; }

add_to_env MATLABPATH "$script_place"
add_to_env MATLABPATH "$script_place/misc/classes"
add_to_env MATLABPATH "$script_place/misc/libs"
add_to_env MATLABPATH "$script_place/misc/scripts/util"
add_to_env MATLABPATH "$script_place/misc/epsutil"
