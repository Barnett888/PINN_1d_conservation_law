function [rp] = wshift2(char,r,idec)
%
[m,n] = size(r) ;
%
if char == '1D' 
%
if idec == 1

rp(1:n-1) = r(2:n) ;
%rp(n) = r(1) ;
rp(n) = r(n-1) ;
elseif idec == -1

rp(2:n) = r(1:n-1) ;
%rp(1) = r(n) ;
rp(1) = r(2) ;

else 

'erreur dans la routine wshift-replace.m'
'valeur inconnue de idec '
idec


end
%
else
%
'erreur dans la routine wshift-replace.m'
'chaine de caracteres inconnue '
char

end
