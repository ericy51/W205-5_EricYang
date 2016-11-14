import psycopg2
import sys

conn = psycopg2.connect(database="postgres", user="w205", password="pass", host="localhost", port="5432")
cur = conn.cursor()

if len(sys.argv) > 1:
    cur.execute("SELECT word,count from Tweetwordcount WHERE word =%s", [sys.argv[1]])
    records = cur.fetchall()
    conn.commit()

    if not records:
        print("No results for your query")
    if records:
        print("Total number of ocurrences of '" + sys.argv[1] + "' : " + str(records[0][1]))

if len(sys.argv) == 1:
    cur.execute("SELECT word,count from Tweetwordcount ORDER BY  word asc")
    records = cur.fetchall()
    conn.commit()
    print(records)
