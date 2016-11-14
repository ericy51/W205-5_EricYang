pip install psycopg2
pip install tweepy

#copy all files to user directory
mkdir /home/w205/exercise_2
cp -a ./ /home/w205/exercise_2

#wordcount folder

su - w205 -c "sparse quickstart wordcount"
su - w205 -c "rm wordcount/src/spouts/words.py"
su - w205 -c "rm wordcount/src/bolts/wordcount.py"
su - w205 -c "rm wordcount/topologies/wordcount.clj"

#move files to streaming directories
su - w205 -c "cp exercise_2/tweets.py wordcount/src/spouts"
su - w205 -c "cp exercise_2/parse.py wordcount/src/bolts"
su - w205 -c "cp exercise_2/wordcount.py wordcount/src/bolts"
su - w205 -c "cp exercise_2/tweetwordcount.clj wordcount/topologies"

#Postgres Setup
su - w205 -c "initdb -D /home/w205/data"
su - w205 -c "pg_ctl -D /home/w205/data -l logfile start"

su - w205 -c "python /home/w205/exercise_2/create_postgres_db.py"

su - w205 -c "cd wordcount && sparse run"
