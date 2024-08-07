Initializing a Git repository
the first step is to initialize a Git repository. 

    Open Git Bash.

    Navigate to the root directory of your project.

    Initialize the EMPTY  local directory as a Git repository. By default, the initial branch is called main.

    If you’re using Git 2.28.0 or a later version, you can set the name of the default branch using -b.

    git init -b main

    if this is old git directry, it will reinitialized and in this case need to change owner:
 
              git config --global --add safe.directory D:/projects_old/V_meter/V_meter_013

    Add the files in your new local repository. This stages them for the first commit.

    $ git add .
    # Adds the files in the local repository and stages them for commit. To unstage a file, use 'git reset HEAD YOUR-FILE'.

    Commit the files that you've staged in your local repository.

    $ git commit -m "First commit"
    # Commits the tracked changes and prepares them to be pushed to a remote repository. To remove this commit and modify the file, use 'git reset --soft HEAD~1' and commit and add the file again.



    Adding a local repository to GitHub using Git

Before you can add your local repository to GitHub using Git, you must authenticate to GitHub on the command line. For more information, see "About authentication to GitHub."

    Create a new repository on GitHub.com. To avoid errors, do not initialize the new repository with README, license, or gitignore files. You can add these files after your project has been pushed to GitHub. For more information, see "Creating a new repository."

    At the top of your repository on GitHub.com's Quick Setup page, click 

    to copy the remote repository URL. for example, it will be:

    https://github.com/antondrroid/test_new_local_repository.git

    Screenshot of the "Quick Setup" header in a repository. Next to the remote URL, an icon of two overlapping squares is highlighted with an orange outline.

    Open Git Bash.

    Change the current working directory to your local project.

    To add the URL for the remote repository where your local repository will be pushed, run the following command. Replace REMOTE-URL with the repository's full URL on GitHub.

    git remote add origin https://github.com/antondrroid/test_new_local_repository.git

    For more information, see "Managing remote repositories."

    To verify that you set the remote URL correctly, run the following command.

    git remote -v

answer must be looks like:

            PS D:\projects_old\test_new_local_repository> git remote -v
            origin  https://github.com/antondrroid/test_new_local_repository.git (fetch)
            origin  https://github.com/antondrroid/test_new_local_repository.git (push)

    To push the changes in your local repository to GitHub.com, run the following command.

    git push origin main
if not work, try 
          git push origin /  git push -u origin main
if say:
fatal: The current branch ain has no upstream branch.
To push the current branch and set the remote as upstream, use
       
        git push --set-upstream origin ain

    If your default branch is not named "main," replace "main" with the name of your default branch. For more information, see "About branches."


if remote branch was changed and local has changed too, undepenentaly,
for example, you create in remote file readme.md, but no pushed your loal files to remote yet,
so you has 3 files on local server and one only on remote! 


 use:

PS D:\projects_old\test> git pull origin main
From https://github.com/antondrroid/test
 * branch            main       -> FETCH_HEAD
fatal: refusing to merge unrelated histories  (not syncronized changes, and pull not work as usual)
PS D:\projects_old\test> ls


    Directory: D:\projects_old\test


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----          8/6/2024   4:13 PM                contract
-a----          8/6/2024   3:21 PM           3235 readme.txt
-a----          8/6/2024   1:31 PM              0 depth_of_commits.txt


PS D:\projects_old\test> git pull origin main --allow-unrelated-histories
From https://github.com/antondrroid/test
 * branch            main       -> FETCH_HEAD
Merge made by the 'ort' strategy.
 README.md | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
PS D:\projects_old\test> ls


after that , use 

git push -u origin main 

and README.MD will be pulled to local server. 


    Directory: D:\projects_old\test


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----          8/6/2024   4:13 PM                contract
-a----          8/6/2024   3:21 PM           3235 readme.txt
-a----          8/6/2024   1:31 PM              0 depth_of_commits.txt
-a----          8/6/2024   5:22 PM              8 README.md


if somebody edit he project, while you are trip to  home, and after come, begin edit project, not pul 
before, you will cannot nor pull, nor push.

Further reading

    "Adding a file to a repository"
    "Troubleshooting the 2 GB push limit"


