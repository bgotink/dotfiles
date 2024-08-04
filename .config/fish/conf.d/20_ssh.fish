set -gx SSH_AUTH_SOCK $HOME/.ssh/agent-socket

if ! test -S $SSH_AUTH_SOCK
	ssh-agent -a $SSH_AUTH_SOCK >/dev/null
end
