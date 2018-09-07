#### General ####

# Delete all non-commited files (- etags file) TODO: follow up with a `cp_secrets`
gnuke () 
{ 
    echo "Comfirm deletion of the following files? (Remember all non-added files will be removed)"
    git clean -fdxn &&
    while true; do
        read -s -n 1 C
        case $C in
            [y]* ) git clean -fdx -e ".tags" -e \".tags_sorted_by_file\"; break;;
            [n]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

#### Branches ####

# TODO: add comment stating if branch has been merged with master
# TODO: echo "Deleted <branch>" correctly
rm_od ()
{
    for k in $(git branch | sed /\*/d); do 
    # NOTE: change '-z' to '-n' to filter by BEFORE date
      if [ -z "$(_br_la $k)" ]; then
        # git branch -D $k
        echo "Comfirm deletion of branch $(git log -1 --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'$k)?"
            while true; do
            read -s -n 1 C
            case $C in
                [y]* ) $(rmbr $k) && echo "Deleted $k"; break;;
                [n]* ) break;;
                [q]* ) break 2;;
                * ) echo "Please answer y or n.";;
            esac
        done
      fi
    done
}


#### All File Changes ####

rm_untracked () 
{ 
    echo "Comfirm deletion of the following files? (Remember all non-added files will be removed)"
    git clean -n &&
    while true; do
        read -s -n 1 C
        case $C in
            [y]* ) git clean -f; break;;
            [n]* ) break;;
            * ) echo "Please answer y or n.";;
        esac
    done
}
