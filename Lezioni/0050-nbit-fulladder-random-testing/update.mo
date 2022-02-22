
function  update
input Integer old;
input Integer n;
output Integer new;

algorithm

if (old < (2^n - 1))
then
  new := old + 1;
else
  new := 0;
end if; 

end update;

