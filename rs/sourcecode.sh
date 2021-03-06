#!/bin/sh -e

str()
{
    awk '{
            gsub("^\\.\\./", "");

            x = $0; gsub("^\\.\\./", "", x);
            gsub("bunsan/bacs", "bacs", x);
            gsub("bacs/repository/bacs/system/", "", x);
            gsub("bacs/problem_plugins", "bacs/problem", x);
            gsub(".*/include/", "", x);

            gsub("_", "\\_", x);
            print "\\lstinputlisting[title="x"]{"$0"}";
        }'
}

gen()
{
    for i
    do
        find "../../$i" -type f -name '*.hpp' -o -name '*.py' -o -name '*.proto' | \
            grep -v /detail/ | \
            grep -v /web/ | \
            grep -v /compatibility/ | \
            egrep -v '/none_dcs\.py$' | \
            egrep -v '/common\.hpp$' | \
            egrep -v '/pb/convert\.hpp$' | \
            egrep -v '/problem/split\.hpp$' | \
            egrep -v '/error\.hpp$' | \
            egrep -v '/config\.hpp$' | \
            str
    done
}

genp()
{
    gen "$1/include"
}

secraw()
{
    cmd="$1"
    section="$2"
    shift 2

    echo '\section{'"$(echo "$section" | sed -r 's|_|\\_|g')"'}'
    echo
    "$cmd" "$@"
    echo
}

sec()
{
    secraw gen "$@"
}

secp()
{
    secraw genp "$@"
}

echo '\chapter{Исходный код}'
echo

sec bunsan::worker bunsan/worker_python/src

secp bunsan::pm bunsan/pm

secp bacs::archive bunsan/bacs/archive

secp bacs::statement_provider bunsan/bacs/statement_provider

secp bacs::problem bunsan/bacs/common bunsan/bacs/problem

secp bacs::problem::single bunsan/bacs/problem_plugins/single

sec bacs::repository bunsan/bacs/repository/bacs/system
