function duration = test_par_job(n_workers)
%TEST_PAR_JOB   Run a test job with a parpool.
%
%  duration = test_par_job(n_workers)

if paropen()
  delete(gcp('nocreate'))
end

% open up a job-specific parpool
fprintf('Opening parallel pool...\n')
tic
[pool, cluster] = job_parpool(n_workers);
fprintf('Done. Took %.4f s.\n', toc)

% display pool and cluster information for debugging purposes
get(cluster)
disp(pool)
get(cluster.Jobs)
get(cluster.Jobs.Tasks(1))
get(cluster.Jobs.Tasks(1).Worker)

duration = [];

% pause before the parfor loop; this seems to affect execution speed
pause(30)

% run a simple parfor loop. The corresponding for loop would take
% about [n_workers * 10] s
fprintf('Running parfor loop...\n')
tic
n_pause = n_workers * 10;
parfor i = 1:n_pause
  pause(1);
end
duration = toc;
fprintf('Done. Took %.4f seconds to run %d 1 s pauses\n', ...
        duration, n_pause)
fprintf('Speedup factor is: %.4f\n', n_pause / duration)
fprintf('Theoretical max speedup: %d\n', n_workers)
