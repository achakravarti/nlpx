# nlpx
Experiments with NLP

```
git clone https://github.com/achakravarti/nlpx.git
cd nlpx
virtualenv --python=/usr/bin/python3.6 env
source env/bin/activate
pip install nltk
```

```
sudo -i -u postgres
[postgres]$ psql
postgres=# CREATE DATABASE nlpx;
postgres=# CREATE USER nlpx WITH PASSWORD 'your-password';
postgres=# ALTER ROLE nlpx SET client_encoding TO 'utf8';
postgres=# ALTER ROLE nlpx SET default_transaction_isolation TO 'read committed';
postgres=# ALTER ROLE nlpx SET timezone TO 'UTC';
postgres=# GRANT ALL PRIVILEGES ON DATABASE nlpx TO nlpx;
postgres=# \q
```
