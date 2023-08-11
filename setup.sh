source .env

# check the project is cloned by git
if [ ! -d .git ]; then
    echo "Please clone the project by git"
    exit 1
fi

# remove webconf/ directory and reset with git
rm -rf webconf/
git restore webconf/

sed -i "s/taxi.example.com/${DNS}/g" webconf/sites-enabled/taxi

if [ ! -f ssl-dhparams.pem ]; then
    sudo openssl dhparam -out ssl-dhparams.pem 4096
fi

sudo docker compose pull
# check docker container is already running
# if runninng, compose down
# then compose up
if [ "$(sudo docker ps -q -f name=taxi-server)" ]; then
    sudo docker compose down
fi

sudo docker compose up -d

printf "\033[0;32mDeploy Success!\033[0m\n"

