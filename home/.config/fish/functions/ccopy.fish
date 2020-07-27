# Defined in - @ line 1
function ccopy --wraps='xsel --clipboard --input' --description 'alias ccopy=xsel --clipboard --input'
  xsel --clipboard --input $argv;
end
