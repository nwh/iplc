%snchessstr hessian structure for snc problem

function Hstr = snchessstr()
  Hstr = sparse(tril(ones(2)));
end