# brew install colima docker

colima start --memory 4 --cpu 2 --disk 20

docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=YourPassword123' \
  -p 1433:1433 --name sqlserver \
  -d mcr.microsoft.com/mssql/server:2019-latest

docker ps

docker start sqlserver

docker stop sqlserver
