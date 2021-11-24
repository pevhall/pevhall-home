function clearDir --description 'remove everything in the current directory'
set -l dir (basename $PWD)
cd ..
rm -r $dir
mkdir $dir
cd $dir
end
