1. Create a public repo called shell-practice, clone it, protect main, and open an issue. Then create a branch
git clone git@github.com:i-wajidrashid/shell-practice.git
cd shell-practice
git checkout -b solve-shell-practice

2. Save some real system logs to a file with journalctl -n 5000 > system.log
journalctl -n 5000 > system.log

3. Count how many lines the file has
wc -l system.log

4. Find every line containing the word error, ignoring upper and lower case
grep -i "error" system.log

5. Count those lines by piping grep into wc -l
grep -i "error" system.log | wc -l

6. Show the 10 most common programs in the log, using cut, sort, uniq -c and sort -rn
cut -d ' ' -f 5 system.log | cut -d '[' -f 1 | cut -d ':' -f 1 | sort | uniq -c | sort -rn | head -n 10

7. Find every .log file under /var/log with find. Some folders will refuse you. Find out why
find /var/log -name "*.log"
ls -ld /var/log/private
Reason: Restricted folders like /var/log/private are owned by root with drwx------ (700) permissions, so standard users do not have read or execute permissions to access them without sudo.

8. Create a script file and try to run it. It will fail. Fix it with chmod
echo 'echo "Script works!"' > script.sh
./script.sh
chmod +x script.sh
./script.sh

9. Run sleep 300 in one terminal. In another, find it with ps and stop it with kill
sleep 300
ps aux | grep sleep
kill PID

10. Add system.log to .gitignore, because logs do not belong in Git
echo "system.log" >> .gitignore

11. Open a pull request that closes the issue, and merge it
git add .gitignore ANSWERS.md script.sh
git commit -m "Add shell practice solutions (Closes #1)"
git push -u origin solve-shell-practice
