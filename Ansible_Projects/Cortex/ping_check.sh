for host in $(cat ); do
    if ping -c 2 $host >/dev/null; then
        echo "$host" >> ssh_fail222.txt
    else
        echo "$host" >> down222.txt
    fi
done


