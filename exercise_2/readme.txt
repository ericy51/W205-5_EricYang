Run everything from root.  The script will take care of creating directories/files as the w205 user.  To interact with the serving scripts switch to the w205 user when you after you are satisfied with the stream of tweets.

Instructions
git clone git@github.com:ericy51/W205-5_EricYang.git
cd W205-5_EricYang/exercise_2
chmod +x ./ex2_setup.sh
./ex2_setup.sh

•	Notes:  Creating a streamparse project called EX2Tweetwordcount in Streamparse was causing errors so I created a project called wordcount instead.  Instead of using Tcount as my database name in postgres I used the database name postgres.  Also when using git clone I needed to add an SSH key to my repository every time I created a new AMI.  Not sure if you'll encounter this problem.
