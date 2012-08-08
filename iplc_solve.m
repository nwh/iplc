%iplc  solve LC problem with ipopt
%
% Input structure fields:
%   name = problem name
%   usrfun = handle to objective function
%   usrgrad = handle to gradient
%   usrhess = handle to sparse hessian, can be tril
%   hesspat = handle to sparse hessian pattern, can be tril
%   x0 = initial guess
%   bl = lower bound for variable
%   bu = upper bound for variable
%   A = sparse linear constraint matrix
%   cl = lower bound for constraint
%   cu = upper bound for constraint
%   options_struct = ipopt options structure
%   print_file = print file, uses Matlab diary
%   print_level = ipopt print level, default 5
%   
% Output structure fields:
%   xstar = solution vector
%   into = ipopt info structure
%   fevcnt = number of function evals
%

function out = iplc_solve(varargin)
  
  % use inputParse to handle inputs
  in_parse = inputParser;  
  in_parse.addParamValue('name','iplc-problem',@(x) ischar(x));
  in_parse.addParamValue('usrfun',[],@(x) isa(x,'function_handle'));
  in_parse.addParamValue('usrgrad',[],@(x) isa(x,'function_handle'));
  in_parse.addParamValue('usrhess',[],@(x) isa(x,'function_handle'));
  in_parse.addParamValue('hesspat',[],@(x) ismatrix(x));
  in_parse.addParamValue('x0',[],@(x) isvector(x));
  in_parse.addParamValue('bl',[],@(x) isvector(x) || isempty(x));
  in_parse.addParamValue('bu',[],@(x) isvector(x) || isempty(x));
  in_parse.addParamValue('A',[],@(x) ismatrix(x) || isempty(x));
  in_parse.addParamValue('cl',[],@(x) isvector(x) || isempty(x));
  in_parse.addParamValue('cu',[],@(x) isvector(x) || isempty(x));
  in_parse.addParamValue('options_struct',[],@(x) isstruct(x) || isempty(x));
  in_parse.addParamValue('print_file',[],@(x) ischar(x) || isempty(x));
  in_parse.addParamValue('print_level',5,@(x) 0 <= x && x <= 12);
  
  % process inputs
  in_parse.parse(varargin{:});
  prob = in_parse.Results;
  
  % output default structure if desired
  if nargin == 0 || ischar(varargin{1})
    out = prob;
    return;
  end
  
  % process bounds on variables
  nvar = length(prob.x0);
  if isempty(prob.bl)
    prob.bl = -inf(nvar,1);
  end
  if isempty(prob.bu)
    prob.bu = inf(nvar,1);
  end

  % process bounds on constraints
  ncon = 0;
  if ~isempty(prob.A)
    ncon = size(prob.A,1);
    if isempty(prob.cl)
      prob.cl = -inf(ncon,1);
    end
    if isempty(prob.cl)
      prob.cu = inf(ncon,1);
    end
  end
  
  % instrument for function eval count
  fevcnt = 0;
  function f = anon_usrfun(x)
    fevcnt = fevcnt + 1;
    f = prob.usrfun(x);
  end

  % objective function
  funcs.objective = @(x) anon_usrfun(x);
  funcs.gradient = @(x) prob.usrgrad(x);
  funcs.hessian = @(x,sigma,lambda) sigma*tril(prob.usrhess(x));
  funcs.hessianstructure = @() tril(prob.hesspat);

  % constraints
  if ~isempty(prob.A)
    funcs.constraints = @(x) prob.A*x;
    funcs.jacobian = @(x) prob.A;
    funcs.jacobianstructure = @() prob.A;
    options.cl = prob.cl;
    options.cu = prob.cu;
  end
  
  % set bounds
  options.lb = prob.bl;
  options.ub = prob.bu;

  % ipopt options
  options.ipopt = prob.options_struct;

  % set the print level
  options.ipopt.print_level = prob.print_level;
  
  % open the print/diary file
  if ~isempty(prob.print_file)
    diary(prob.print_file);
  end
  
  % constraints are linear
  if ~isempty(prob.A)
    options.ipopt.jac_c_constant = 'yes';
    options.ipopt.jac_d_constant = 'yes';
  end

  % test things
  %x0 = prob.x0;
  %f = funcs.objective(x0);
  %g = funcs.gradient(x0);
  %H = funcs.hessian(x0,1,0);
  %Hp = funcs.hessianstructure();
  
  [out.xstar out.info] = ipopt(prob.x0,funcs,options);
  out.fevcnt = fevcnt;
  out.fstar = funcs.objective(out.xstar);
  
  %keyboard

  % close the diary
  if ~isempty(prob.print_file)
    diary off;
  end

end
