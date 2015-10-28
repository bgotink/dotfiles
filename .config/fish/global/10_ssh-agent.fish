# try to load SSH-agent

set SSH_ENV "$HOME/.ssh/environment"

function read_ssh_env
    # run bash to get info
    eval (cat $SSH_ENV)
end

function start_agent
    echo "Initializing new SSH agent..."
    ssh-agent -c | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo "Agent initialized..."

    # protect file from other users
    chmod 600 "$SSH_ENV"

    # load file
    read_ssh_env

    # add ssh keys
    echo "Autoloading keys in ~/.ssh"
    cd ~/.ssh;
    ssh-add (ls | grep '^id_' | grep -v '.pub$');
    cd -;
end

# Source SSH settings, if applicable

if test -f "$SSH_ENV"
    read_ssh_env
    # ps $SSH_AGENT_PID doesn't work under cywgin
    ps -ef | grep $SSH_AGENT_PID | grep --quiet 'ssh-agent -c$'; or start_agent;
else
    start_agent;
end

functions -e start_agent
functions -e read_ssh_env
