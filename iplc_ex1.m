function iplc_ex1

iplc_prob = iplc_solve();

iplc_prob.usrfun = @(x) sncfun(x);
iplc_prob.usrgrad = @(x) sncgrad(x);
iplc_prob.usrhess = @(x) snchess(x);
iplc_prob.hesspat = snchessstr();
iplc_prob.x0 = [2; 0];
%iplc_prob.bl = [-10; -10];
%iplc_prob.bu = [10; 10];

iplc_prob.options_struct.tol = 1e-6;

iplc_prob

iplc_solve(iplc_prob)

end