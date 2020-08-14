![](https://github.com/cassiodiego/white-label-loyalty-app/workflows/white-label-loyalty-app/badge.svg)

# white-label-loyalty-app
Unlabeled loyalty app

## Architecture
![Architecture](https://docs.whitelabelloyalty.app/img/white-label-loyalty-app.png)

## Database
![MER](https://docs.whitelabelloyalty.app/img/white-label-loyalty-db.png)

## Running Database on Docker
```
docker run --name mysql -e MYSQL_USER=white-label-loyalty-db -e MYSQL_PASSWORD=white-label-loyalty-db -e MYSQL_DATABASE=white-label-loyalty-db  -p 3306:3306 -d mysql/mysql-server:5.7
```
```
docker exec -it mysql mysql -u white-label-loyalty-db -pwhite-label-loyalty-db
```
