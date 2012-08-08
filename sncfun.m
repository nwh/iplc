%sncfun  simple negative curvature function and gradient

function f = sncfun(x)
  
  f = 0.5*(x(1)^2-x(2)^2) + 0.25*(x(1)^4+x(2)^4);
    
end