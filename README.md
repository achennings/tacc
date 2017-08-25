# tacc
Utilities for using TACC resources

## Submitting jobs

There are multiple ways to submit jobs on Lonestar and Stampede:

* `sbatch` - This is the command used to submit batch jobs to the SLURM scheduler. The other methods below use sbatch, and just try to make using it easier. See e.g. the TACC Lonestar 5 documentation for details and sample scripts.
* `launch` - Script to make it easier to run parametric jobs (i.e. running many commands in parallel, across multiple cores in a node or across multiple nodes). Can also run single commands, in a similar way to sbatch. It's a python script that generates sbatch scripts and submits them. For running parametric jobs, uses the TACC Launcher (this requires first running `module load launcher`).
* `submit_job.sh` Script to help organize output from launch, including input commands, sbatch settings, and command output.

## Initialization scripts

These sample scripts are in `tacc/init`, and can be used to set up your environment to make some things easier:

* `ssh_config_nwm` Put this in `~/.ssh/config` on your computer, and replace “mortonne” with your username on TACC. It just defines addresses and settings to make using ssh to remotely access machines like Lonestar simpler. So instead of typing `ssh -Y mortonne@ls5.tacc.utexas.edu` every time, you can just type `ssh lonestar`. This also works for scp and rsync commands to move files to and from Lonestar (e.g. `scp myfile lonestar:` to copy myfile to your home directory on Lonestar). There is also an entry for “ilonestar”, meaning “interactive lonestar”, which points to the IRC’s virtual login node. This is the best place to run interactive things like looking at images in fslview. If you want access, email the IRC helpdesk with your TACC ID to request access.
* `dot_bashrc_nwm` Put this in `~/.bashrc` on Lonestar, or copy relevant code into your existing one (TACC sets up one for you automatically). These commands run every time you ssh into Lonestar, and every time a job starts. This is where you do things like load modules or change the PATH variable to install software. It also sets the “umask”, which sets the default for the permissions that new files will have. 002 means that every new file I create will be readable and writable for members of my group (i.e. the Preston lab). This file also defines the commands I use to check on the status of the queue (e.g. q, qi), and has a brief explanation of what each command does.
* `dot_emacs_nwm` If you use Emacs, put this in `~/.emacs` on your computer. Among other things, it makes it so you can access files on Lonestar remotely (my edits make it so the two-factor authentication works properly) using the TRAMP functionality built into Emacs. This is the smoothest and fastest way I’ve found to edit files on Lonestar, though it does require learning a little bit about Emacs. To ssh to lonestar (given an ssh config set like the one above), type: ctrl-X ctrl-F, then `/ssh:lonestar:path/to/file`.
