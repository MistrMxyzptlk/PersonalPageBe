#! /bin/bash

printf "building packages: \n"
npm run build:prod

printf "clearing directory: \n"
ssh -i ~/.ssh/pipeline_rsa pipeline@mixspitlick.tech 'rm -rf ./server/*'

printf "deploying packages\n"
cd ./dist && tar -cvzf ../build.tar.gz . && cd ../
scp -i ~/.ssh/pipeline_rsa ./build.tar.gz pipeline@mixspitlick.tech:
ssh -i ~/.ssh/pipeline_rsa pipeline@mixspitlick.tech 'tar -xvf ./build.tar.gz -C ./server && rm ./build.tar.gz'

printf 'build complete!\n'
rm -rf ./dist
rm build.tar.gz