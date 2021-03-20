import json
import psycopg2
from psycopg2.extras import RealDictCursor


class Database:
    def __init__(self):
        self.__conn = psycopg2.connect(database='nlpx', user='nlpx')
        self.__conn.set_session(autocommit=True)


    def __del__(self):
        self.__conn.close()


    def script(self, script):
        """
        Executes an SQL script file.
        """

        with self.__conn.cursor() as cur:
            cur.execute(open('sql/' + script + '.sql', 'r').read())


    def proc(self, proc, params=None, args=None):
        """
        Executes a PostgreSQL stored procedure.
        """

        with self.__conn.cursor() as cur:
            if params is None:
                cur.execute("CALL " + proc + "();")
            else:
                cur.execute("CALL " + proc + "(" + params + ");", args)


    def func(self, func, args=None):
        """
        Executes a PostgreSQL function.
        """

        with self.__conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.callproc(func, args)
            return json.dumps(cur.fetchall(), indent=2)
