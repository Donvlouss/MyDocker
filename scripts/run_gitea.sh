docker run -d --privileged=true --restart=always \
    --name=gitea -p 12022:22 -p 29419:3000 \
    -v //e/Gitea:/data \
    gitea/gitea:latest