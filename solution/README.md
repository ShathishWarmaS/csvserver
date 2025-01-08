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

1. **Create a docker-compose.yaml file for the setup from part I.**
    Use an environment variable file named csvserver.env in docker-compose.yaml to pass environment variables used in part I.

    One should be able to run the application with docker-compose up.

# CSVServer Solution - Part III

1. **Add Prometheus container (prom/prometheus:v2.45.2) to the docker-compose.yaml form part II.**



