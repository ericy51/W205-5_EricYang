pip install psycopg2
pip install tweepy

#copy all files to user directory
mkdir /home/w205/exercise_2
cp -a ./ /home/w205/exercise_2

#wordcount folder
su - w205
sparse quickstart wordcount
rm wordcount/src/spouts/words.py
rm wordcount/src/bolts/wordcount.py
rm wordcount/topologies/wordcount.clj

#move files to streaming directories
cp exercise_2/tweets.py wordcount/src/spouts
cp exercise_2/parse.py wordcount/src/bolts
cp exercise_2/wordcount.py wordcount/src/bolts
cp exercise_2/tweetwordcount.clj wordcount/topologies

#Postgres Setup
initdb -D /home/w205/data
pg_ctl -D /home/w205/data -l logfile start

python /home/w205/exercise_2/postgres_create_db.py

cd wordcount
sparse run
