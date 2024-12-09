\#! /bin/bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519_jenkins
ssh -vT git@github.com
cd shopping-cart-spring-boot-main
git reset --hard
git pull origin main
docker builder  prune -f
docker compose stop -t 1 shopping
docker compose rm -f shopping
docker compose up -d --no-deps --build shopping
