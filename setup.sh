source .env

# check the project is cloned by git
if [ ! -d .git ]; then
    echo "Please clone the project by git"
    exit 1
fi

# remove webconf/ directory and reset with git
rm -rf webconf/
git restore webconf/

sed -i "s/backend.example.com/${BACK_DNS}/g" webconf/sites-enabled/backend
sed -i "s/frontend.example.com/${FRONT_DNS}/g" webconf/sites-enabled/frontend

# check webconf/ssl/dh-param.pem is exist
if [ ! -f webconf/ssl/dh-param.pem ]; then
    sudo openssl dhparam -out webconf/ssl/dh-param.pem 4096
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

