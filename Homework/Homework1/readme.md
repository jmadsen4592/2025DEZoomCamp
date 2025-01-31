Question 1:
    BASH:
        docker run -it --entrypoint=bash python:3.12.8
        pip -V
    #returned pip 24.3.1 from /usr/local/lib/python3.12/site-packages/pip (python 3.12)
        
Question 2:
    db:5432

Question 3:
    Jupyter:
        df_iter = pd.read_csv('green_tripdata_2019-10.csv.gz', iterator=True, chunksize=100000, compression = 'gzip')    
        df = next(df_iter)
        df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)
        df.head(n=0).to_sql(name='green_taxi_data', con=engine, if_exists='replace')
        %time df.to_sql(name='green_taxi_data', con=engine, if_exists='append')

        from time import time
        while True:
            t_start = time()
            
            df = next(df_iter)

            df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
            df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

            df.to_sql(name='green_taxi_data', con=engine, if_exists='append')
            t_end = time()

            print('inserted another chunk..., took %.3f second' % (t_end - t_start))

    SQL queries:
    #My reasoning here for using pickup and dropoff to filter dates is that I assume that if a trip starts in october but ends in november it "shouldn't" be included.  
    1. 
        SELECT count(*) FROM green_taxi_data
        WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND
        lpep_dropoff_datetime < '2019-11-01' AND
        trip_distance <= 1
    RESULT = 104802
    2.
        SELECT count(*) FROM green_taxi_data
        WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND
        lpep_dropoff_datetime < '2019-11-01' AND
        trip_distance > 1 AND
        trip_distance <= 3
    RESULT = 198924
    3.
        SELECT count(*) FROM green_taxi_data
        WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND
        lpep_dropoff_datetime < '2019-11-01' AND
        trip_distance > 3 AND
        trip_distance <= 7
    RESULT = 109603
    4.
        SELECT count(*) FROM green_taxi_data
        WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND
        lpep_dropoff_datetime < '2019-11-01' AND
        trip_distance > 7 AND
        trip_distance <= 10
    RESULT = 27678
    5.
        SELECT count(*) FROM green_taxi_data
        WHERE 
        lpep_pickup_datetime >= '2019-10-01' AND
        lpep_dropoff_datetime < '2019-11-01' AND
        trip_distance > 10 
    RESULT = 35189

QUESTION 4:
    SQL:
        SELECT CAST(lpep_pickup_datetime AS DATE) 
        FROM green_taxi_data
        WHERE trip_distance = 
        (SELECT max(trip_distance) FROM green_taxi_data)
    RESULT = 2019-10-31

QUESTION 5:
    SQL:
        SELECT SUM(g.total_amount), z."Zone"
        FROM green_taxi_data g
        JOIN zones z on g."PULocationID" = z."LocationID"
        WHERE CAST(g.lpep_pickup_datetime AS DATE) = '2019-10-18'
        GROUP BY z."Zone"
        HAVING SUM(g.total_amount) > 13000
    RESULT: East Harlem North, East Harlem South, Morningside Heights

QUESTION 6:
    SQL:
        SELECT max(tip_amount), zdo."Zone"
        FROM green_taxi_data g
        JOIN zones zpu on g."PULocationID" = zpu."LocationID"
        JOIN zones zdo on g."DOLocationID" = zdo."LocationID"
        WHERE zpu."Zone" = 'East Harlem North'
        GROUP BY zdo."Zone"
        ORDER BY max(tip_amount) DESC
        LIMIT 1
    RESULT: JFK Airport

QUESTION 7:
    terraform init, terraform apply -auto-approve, terraform destroy