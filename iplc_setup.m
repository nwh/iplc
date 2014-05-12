function iplc_setup(install)

if nargin == 1 && strcmp(install,'install')
  % get userpath directory
  mypath = strsplit(userpath,':');
  mypath = mypath{1};
  % create directory if it does not exist
  % TODO: make this better
  [~,~,~] = mkdir(mypath)
  % open file
  fid = fopen([mypath '/iplc_load.m'],'w');
  % write file
  fprintf(fid,'function load_arcopt\n');
  fprintf(fid,'  addpath(''%s'')\n',pwd);
  fprintf(fid,'  addpath(''%s'')\n',[pwd '/toolbox/ipopt']);
  fprintf(fid,'end\n');
  % close file
  fclose(fid);
  %keyboard
else
  addpath(pwd);
  addpath([pwd '/toolbox/ipopt'])
end

end