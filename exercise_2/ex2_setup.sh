pip install psycopg2
pip install tweepy

#wordcount folder
#su - w205
sparse quickstart wordcount
rm wordcount/src/spouts/words.py
rm wordcount/src/bolts/wordcount.py
rm wordcount/topologies/wordcount.clj

#Postgres Setup
initdb -D /home/w205/data
pg_ctl -D /home/w205/data -l logfile start

python /home/w205/postgres_create_db.py
