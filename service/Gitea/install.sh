Location_Gitea="/c/gitea"
Url_Host="localhost"

while getopts "hp:u:" opt; do
    case $opt in
        h)
            echo "Usage:" \
            "[-p Location_Gitea <default: /c/gitea>] [-u Url_Host <default: localhost>]"
            exit 0
            ;;
        p)
            Location_Gitea=$OPTARG
            ;;
        u)
            Url_Host=$OPTARG
            ;;
    esac
done
shift $((OPTIND-1))

echo "# ==========================================="
echo "# Gitea Location: $Location_Gitea"
echo "# Host: $Url_Host"
echo "# ==========================================="

# mkdir -p $Location_Gitea/gitea/conf
# cp app.ini.template $Location_Gitea/gitea/conf/app.ini
# sed -i "s/0.0.0.0/$Url_Host/" $Location_Gitea/gitea/conf/app.ini

rm -f .env
echo "GITEA_DATA_DIR=/$Location_Gitea" >> .env

docker-compose up -d