name=""
file="ubuntu2004_zsh:latest"

while getopts ":t:f:h:" opt; do
    case $opt in
        t)
            name="$OPTARG"
            ;;
        f)
            file="$OPTARG"
            ;;
        h)
            echo "Usage: $0 [-t name] [-f docker file]"
            exit 0
            ;;
    esac
done

shift $((OPTIND - 1))
echo "Name: $name"
echo "Dockerfile: $file"

docker build -t 

docker build \
    -t "$name" \
    -f "$file" \
    .