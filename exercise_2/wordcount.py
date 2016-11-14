from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()


    def process(self, tup):
        word = tup.values[0]

        conn = psycopg2.connect(database="postgres", user="w205", password="pass", host="localhost", port="5432")
        cur = conn.cursor()

        #check if word is in table
        cur.execute("SELECT word from Tweetwordcount WHERE word =%s", [word])
        records = cur.fetchall()
        conn.commit()

        #not in table then we inset the new word
        if not records:
            cur.execute("INSERT INTO Tweetwordcount (word,count) VALUES (%s,%s)", (word,1))
            conn.commit()

        #if word is in table increment count on existing record
        if records:
            cur.execute("SELECT word, count from Tweetwordcount WHERE word =%s", [word])
            records = cur.fetchall()
            conn.commit()

            new_count = records[0][1]+1
            cur.execute("UPDATE Tweetwordcount SET count=%s WHERE word=%s", (new_count, word))
            conn.commit()

        records = []
        conn.commit()


        # Increment the local count
        self.counts[word] += 1
        self.emit([word, self.counts[word]])

        # Log the count - just to see the topology running
        self.log('%s: %d' % (word, self.counts[word]))
