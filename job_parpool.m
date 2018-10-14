function [pool, cluster] = job_parpool(n_workers)
%JOB_PARPOOL   Create a parpool within an independent job.
%
%  Opening a parpool is complicated when doing it on a compute
%  node. Care must be taken to avoid conflicts with jobs running on
%  other nodes. This function solves one of the problems, namely
%  that independent parpools must store data in separate
%  directories to avoid conflicts. A unique directory with the job
%  ID will be created to store data for the parpool.
%
%  The other problem is that parpools will still conflict with each
%  other if they start at the same time. So different jobs that create
%  parpools must be set to start at different times; this can be
%  accomplished by setting dependencies using SLURM.
%
%  [pool, cluster] = job_parpool(n_workers)

% disabling MPI exec may or may not help; this setup is working, so
% leaving it disabled for now
distcomp.feature('LocalUseMpiexec', false);

% get the local cluster profile for running parpools
n_attempt = 10;
success = false;
for i = 1:n_attempt
  try
    cluster = parcluster('local');
    success = true;
    break
  catch
    fprintf('Problem accessing cluster. Retrying...\n');
    pause(10 * rand);
  end
end

if ~success
  fprintf('Unable to access cluster. Possibly some license checkout issue.\n')
  cluster = [];
  pool = [];
  return
end

% get the ID of the job executing this function
job_id = getenv('SLURM_JOB_ID');
launcher_job = getenv('LAUNCHER_JID');
if ~isempty(launcher_job)
  job_id = [job_id '_' launcher_job];
end

% set a storage directory that is unique to this job, to prevent
% interference from other jobs running parpools
work_dir = getenv('WORK');
local_dir = fullfile(work_dir, 'runs', 'local', job_id);
if ~exist(local_dir, 'dir')
  mkdir(local_dir);
end
cluster.JobStorageLocation = local_dir;

% create a pool with the requested number of workers. Currently
% disabling SPMD to try to avoid problems; this may not be necessary
n_attempt = 10;
success = false;
for i = 1:n_attempt
  try
    delete(gcp('nocreate'))
    pool = parpool(cluster, n_workers, 'SpmdEnabled', false);
    success = true;
    break
  catch
    fprintf('Problem opening parpool. Retrying...\n');
    pause(10 * rand);
  end
end

if ~success
  fprintf('Unable to open parpool.\n');
  pool = [];
end
