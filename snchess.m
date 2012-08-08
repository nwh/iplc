%snchess  simple negative curvature problem hessian

function H = snchess(x)
  H = [1+3*x(1)^2 0; 0 -1+3*x(2)^2];
  H = sparse(H);
end