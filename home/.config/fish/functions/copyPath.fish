function copyPath --description 'copy path'
if count $argv > /dev/null
set path $argv[1]
else
set path $PWD
end
realpath $path | ccopy
end
