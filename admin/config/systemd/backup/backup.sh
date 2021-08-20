#!/bin/bash
find ./ -type f -print0 | tar -czvf backup.tar.gz --null -T -

find ./test -type f -mmin -10 -print0 | tar -czvf backup/b1.tar.gz --null -T -