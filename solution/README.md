# CSVServer Solution - Part I

## Steps to Run the CSVServer Application

1. **Generate the Input File**
   Run the script `gencsv.sh` to generate the `inputFile`:

   ```bash
   ./gencsv.sh 2 8

This creates an input file named inputFile with the following content:

     eg. 2, 14423
    0, <random_value>
    1, <random_value>
    2, <random_value>
    ...
    6, <random_value>

2.	Run the Container
    
    Check it's running or not as per instructions.

     docker run -d -p 9393:9300 -v infracloudio/csvserver:latest

    And after that add the input file with docker run command

     docker run -d -p 9393:9300 -v $(pwd)/inputdata:/csvserver/inputdata infracloudio/csvserver:latest
    
    Run the csvserver container with the input file and set the environment variable CSVSERVER_BORDER:

     docker run -d -p 9393:9300 -e CSVSERVER_BORDER=Orange -v $(pwd)/inputFile:/csvserver/inputdata infracloudio/csvserver:latest

3.	Access the Application

   Open the application in your browser at http://localhost:9393. The application should display the data with an orange border.

4.	Capture the Output

   Save the raw data from the application using curl or wget:

   curl -o ./part-1-output http://localhost:9393/raw

   Alternatively:

   wget -O ./part-1-output http://localhost:9393/raw

5.	Save the Container Logs
    
    Save the container logs to a file named part-1-logs:

    docker logs  164f50d51fe0  >& part-1-logs 

2. Save the Docker Run Command

Create a file named part-1-cmd and save the docker run command used in Step 2:

        echo "docker run -d -p 9393:9300 -e CSVSERVER_BORDER=Orange -v $(pwd)/inputFile:/csvserver/inputdata infracloudio/csvserver:latest" > part-1-cmd

# CSVServer Solution - Part II

1. **docker-compose.yaml Configuration**:
   - Created `docker-compose.yaml` to manage CSVServer and Prometheus together. The following service configuration was used:

     ```yaml
     version: "3.9"
     services:
       csvserver:
         image: infracloudio/csvserver:latest
         container_name: csvserver
         ports:
           - "9393:9300"
         env_file:
           - ./csvserver.env
         volumes:
           - ./inputFile:/csvserver/inputdata/inputFile

       prometheus:
         image: prom/prometheus:v2.45.2
         container_name: prometheus
         ports:
           - "9090:9090"
         volumes:
           - ./Prometheus/prometheus.yml:/etc/prometheus/prometheus.yml
         command:
           - "--config.file=/etc/prometheus/prometheus.yml"
         networks:
           - default
     ```

2. **Running Docker Compose**:
   - To run both containers (CSVServer and Prometheus) using Docker Compose:
     ```bash
     docker-compose up
     ```

3. **Access Prometheus**:
   - Prometheus will be available at `http://localhost:9090`.

# CSVServer Solution - Part III

1. **Add Prometheus to `docker-compose.yaml`**:
   - The configuration for Prometheus was added to the `docker-compose.yaml` file. This includes a volume mount for the Prometheus configuration file and exposing port `9090` for the web interface.
   
   - The Prometheus configuration (`prometheus.yml`) includes the scrape configuration for CSVServer:
   
     ```yaml
     scrape_configs:
       - job_name: 'csvserver'
         static_configs:
           - targets: ['csvserver:9300']
     ```

2. **Verify Prometheus is Scraping Data**:
   - After running `docker-compose up`, Prometheus will start scraping metrics from the CSVServer at `http://csvserver:9300/metrics`.

3. **Access Prometheus UI**:
   - Open Prometheus at `http://localhost:9090`.
   - In the **"Expression"** box, enter `csvserver_records` and click **"Execute"**. You should see a graph with a straight line showing the value `7` over time.

4. **Check Prometheus Targets**:
   - In Prometheus UI, go to **Status > Targets** to ensure the CSVServer target is up.

---

## Files Added

- `docker-compose.yaml`: Docker Compose file to run both CSVServer and Prometheus.
- `prometheus.yml`: Prometheus configuration file to scrape metrics from CSVServer.

## Troubleshooting

- If you don't see the `csvserver_records` metric in Prometheus, ensure that the `/metrics` endpoint is exposed correctly by the CSVServer.
- Check Prometheus logs for any errors related to scraping.

---

## Final Notes

- The solution provides a running instance of CSVServer with metrics being scraped by Prometheus.
- Prometheus can be used to monitor and graph the metrics collected from the CSVServer.



