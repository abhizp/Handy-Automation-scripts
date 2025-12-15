for host in $(cat ); do
    if ping -c 2 $host >/dev/null; then
        echo "$host" >> ssh_fail222.txt
    else
        echo "$host" >> down222.txt
    fi
done

<<<<<<< HEAD

=======
## simple comment to check git edits
>>>>>>> c62e7e7fbd1056cdc0fb74cc794e39d803851897
