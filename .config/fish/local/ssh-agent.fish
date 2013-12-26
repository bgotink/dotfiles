set SSH_ENV "$HOME/.ssh/environment"

function read_ssh_env
    # run bash to get info
    set -l tmpdata (bash -c 'source '$SSH_ENV'; echo $SSH_AUTH_SOCK; echo $SSH_AGENT_PID');
    
    set -xg SSH_AUTH_SOCK $tmpdata[1];
    set -xg SSH_AGENT_PID $tmpdata[2];
end

function start_agent
    echo "Initializing new SSH agent..." >&2
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV"
    echo "Agent initialized..." >&2
    
    # load file
    chmod 600 "$SSH_ENV"
    read_ssh_env
    
    # add ssh keys
    cd ~/.ssh;
    /usr/bin/ssh-add (ls | grep '^id_' | grep -v '.pub$');
    cd -;
end

# Source SSH settings, if applicable

if test -f "$SSH_ENV"
    read_ssh_env
    #ps $SSH_AGENT_PID doesn't work under cywgin
    ps -ef | grep $SSH_AGENT_PID | grep 'ssh-agent$' > /dev/null; or \
        start_agent;
else
    start_agent;
end

functions -e start_agent
functions -e read_ssh_env