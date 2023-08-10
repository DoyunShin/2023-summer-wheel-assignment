source .env

# check the project is cloned by git
if [ ! -d .git ]; then
    echo "Please clone the project by git"
    exit 1
fi

# remove webconf/ directory and reset with git
rm -rf webconf/
git restore webconf/
git pull

sed -i "s/backend.example.com/${BACK_DNS}/g" webconf/sites-enabled/backend
sed -i "s/frontend.example.com/${FRONT_DNS}/g" webconf/sites-enabled/frontend

if [ ! -f /etc/letsencrypt/live/${BACK_DNS}/fullchain.pem ]; then
    echo "Please make sure the domain cert is valid"
    exit 1
fi
if [ ! -f /etc/letsencrypt/live/${BACK_DNS}/privkey.pem ]; then
    echo "Please make sure the domain cert is valid"
    exit 1
fi

sudo docker compose pull
# check docker compose is running
# use docker compose ps to check


sudo docker compose down
sudo docker compose up -d
