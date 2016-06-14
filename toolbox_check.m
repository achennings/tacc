function toolbox_check()

% stats toolbox
n_attempt = 10;
success = false;
for i = 1:n_attempt
  try
    nansum(NaN);
    success = true;
    break
  catch
    fprintf('Problem using stats toolbox. Retrying...\n');
    pause(10 * rand);
  end
end
