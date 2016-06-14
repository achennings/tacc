function destroy_parpool(pool)
%DESTROY_PARPOOL   Delete all temporary files associated with a parallel pool.
%
%  destroy_parpool(pool)

d = pool.Cluster.JobStorageLocation;

if ~exist(d, 'dir')
  fprintf('Directory does not exist: %s\n', d);
  return
end

if ~isa(pool.Cluster, 'parallel.cluster.Local')
  fprintf('Pool does not appear to be a parallel pool. Skipping...\n');
  return
end

% stop the pool and delete job data
delete(pool)

% delete the cluster information (assuming separate cluster for
% each job, so each one is temporary)
delete(fullfile(d, 'matlab_metadata.mat'));
rmdir(d);
