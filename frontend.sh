#!/bin/bash
apt update
apt install nodejs -y ;apt install npm -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/.bashrc
nvm install 14
mkdir /var/www ; cd /var/www
git clone https://github.com/johnmogi/bootcamp-app.git
cd bootcamp-app/
npm i
echo """
PORT=8080
HOST=0.0.0.0
NODE_ENV=development
HOST_URL=http://localhost:8080
COOKIE_ENCRYPT_PWD=superAwesomePasswordStringThatIsAtLeast32CharactersLong!

# Okta configuration
OKTA_ORG_URL="https://dev-96311573.okta.com"
OKTA_CLIENT_ID="0oa57uv2e4ZbMvc8b5d7"
OKTA_CLIENT_SECRET="-dS3ittft57jAzdyGrR1AmJhVD9qr2xapEJla7MF"

# Postgres configuration
PGHOST=34.90.138.223
PGUSERNAME=postgres
PGDATABASE=postgres
PGPASSWORD=hxfTU0875GCi
PGPORT=5432
""" > .env
npm run initdb
sudo npm i -g pm2
# pm2 start start.sh --name weight
pm2 start npm -- start --name weight
# sudo env PATH=$PATH:/usr/local/bin pm2 startup -u azureuser
sudo env PATH=$PATH:/home/azureuser/.nvm/versions/node/v14.19.3/bin /usr/local/lib/node_modules/pm2/bin/pm2 startup systemd -u azureuser --hp /home/azureuser
sudo systemctl start pm2-azureuser
pm2 savecd ..

