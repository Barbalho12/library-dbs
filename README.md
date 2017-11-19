# RARE

Database for a library management system.

The name RARE is an acromyn for lib**RA**ry manage**R** syst**E**m.


## Execution Tutorial

Install dependencies

```bash
sudo apt install postgresql-9.5
sudo apt install python-psycopg2
```

Update postgres user (set new password)

```
sudo -u postgres psql

postgres=# ALTER USER postgres PASSWORD 'postgres';
postgres-# \q
```

Grant local access

```
psql -U postgres -h localhost

postgres-# \q
```

Running program

```bash
cd open_data
python bd.py
```



