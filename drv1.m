

[prob flag msg] = mcute_build('problem','ROSENBR')
[usrf usrh x0 bl bu A cl cu] = mcute_init(prob);

iplc_prob = iplc_solve();

iplc_prob.usrfun = @(x) mcute_func(x);
iplc_prob.usrgrad = @(x) mcute_grad(x);
iplc_prob.usrhess = @(x) mcute_sphess(x);
iplc_prob.hesspat = mcute_sphess_pat(prob.x);
iplc_prob.A = A;
iplc_prob.cl = cl;
iplc_prob.cu = cu;
iplc_prob.x0 = x0;
iplc_prob.bl = bl;
iplc_prob.bu = bu;

iplc_prob.print_file = 'bam.txt';


out = iplc_solve(iplc_prob)

mcute_clean