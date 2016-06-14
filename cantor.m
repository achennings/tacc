function s = cantor(verbose)
%CANTOR   Get an integer for a launch task that is unique across the cluster.
%
%  s = cantor(verbose)

if nargin < 1
  verbose = true;
end

% number that is almost certainly unique among all current jobs (will
% wrap around after 10000 jobs)
k1 = mod(str2num(getenv('SLURM_JOB_ID')), 10000);

if isempty(k1)
  % not in a job; assume this is the only search currently running,
  % so it's safe to use the current time as a seed
  if verbose
    fprintf('Using current time as random seed.\n')
  end
  s = 'shuffle';
  return
end

% number that is unique within the current job
k2 = str2num(getenv('LAUNCHER_JID'));

if isempty(k2)
  % not using launcher; can just base the seed on the slurm ID
  if verbose
    fprintf('Using slurm ID as random seed.\n')
  end
  s = k1;
  return
end

% construct a unique seed based on slurm ID and launcher ID
if verbose
  fprintf('Setting random seed based on slurm ID and launcher ID.\n')
end
s = .5 * (k1 + k2) * (k1 + k2 + 1) + k2;
