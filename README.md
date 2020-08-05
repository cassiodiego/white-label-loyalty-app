# white-label-loyalty-app
Unlabeled loyalty app

## Architecture
![Architecture](Resources/Docs/white-label-loyalty-app.png)

## Database
![MER](Resources/Docs/white-label-loyalty-db.png)

## Running Database on Docker
```
docker run --name mysql -e MYSQL_USER=white-label-loyalty-db -e MYSQL_PASSWORD=white-label-loyalty-db -e MYSQL_DATABASE=white-label-loyalty-db  -p 3306:3306 -d mysql/mysql-server:5.7
```
```
docker exec -it mysql mysql -u white-label-loyalty-db -pwhite-label-loyalty-db
```
