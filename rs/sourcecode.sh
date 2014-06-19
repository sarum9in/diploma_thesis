#!/bin/sh -e

gen()
{
    find "../../$1" -type f -name '*.?pp' -o -name '*.py' | sed -r 's|^\.\./(.*)$|\\lstinputlisting{\1}|'
}

genp()
{
    gen "$1/include"
    gen "$1/src"
}

echo '\chapter{Исходный код}'
echo
echo '\section{bunsan::worker}'
echo
gen bunsan/worker_python/src
echo
echo '\section{bunsan::pm}'
echo
genp bunsan/pm
echo
echo '\section{bacs::archive}'
echo
genp bunsan/bacs/archive
echo
echo '\section{bacs::problem}'
echo
genp bunsan/bacs/problem
echo
echo '\section{bacs::problem::single}'
echo
genp bunsan/bacs/problem_plugins/single
echo
echo '\section{bacs::system}'
echo
genp bunsan/bacs/system
echo
echo '\section{bacs::repository}'
echo
gen bunsan/bacs/repository/bacs/system
echo
echo '\section{yandex::contest::system}'
echo
genp yandex.contest/system
echo
echo '\section{yandex::contest::invoker}'
echo
genp yandex.contest/invoker
echo
