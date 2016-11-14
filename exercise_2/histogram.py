import psycopg2
import sys

conn = psycopg2.connect(database="postgres", user="w205", password="pass", host="localhost", port="5432")
cur = conn.cursor()

if len(sys.argv) > 1:
    numbers = sys.argv[1].split(",")

    while True:
        try:
            if len(numbers) != 2:
                print("Enter Two Integers in the format X,Y")
                exit()
            cur.execute("SELECT word,count from Tweetwordcount WHERE count >=%s and count <=%s ORDER BY count desc", (int(numbers[0]),int(numbers[1])))
            records = cur.fetchall()
            conn.commit()

            if records:
                for r in records:
                    print(r[0] + ":" + str(r[1]))
            else:
                print("Your query returned no results")
            exit()
        except ValueError:
            print("Enter two integers in the format X,Y")
            exit()
