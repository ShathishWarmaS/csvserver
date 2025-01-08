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
