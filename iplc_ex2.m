
function drv3
  
  % data
  x0 = [2; 0];
  options.lb = [-10; -10];
  options.ub = [10; 10];
  
  
  % instrument for function eval count
  fevcnt = 0;
  function f = anon_usrfun(x)
    fevcnt = fevcnt + 1;
    f = sncfun(x);
  end
  
  % functions
  funcs.objective = @anon_usrfun;
  funcs.gradient = @sncgrad;
  funcs.hessianstructure = @snchessstr;
  funcs.hessian = @(x,sigma,lambda) sigma*snchess(x);
  
  % options
  options.ipopt.print_level = 5;
  %options.ipopt.tol         = 1e-7;
  %options.ipopt.max_iter    = 100;
  
  % run the funcs
  f = funcs.objective(x0);
  g = funcs.gradient(x0);
  Hp = funcs.hessianstructure();
  H = funcs.hessian(x0,1,0);
  
  % solve
  [x info] = ipopt(x0,funcs,options);
  
  x
  info
  
  keyboard
  
end