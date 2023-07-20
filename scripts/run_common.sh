name=""
image="ubuntu2004_zsh:latest"
port=30022

while getopts ":n:i:hp:" opt; do
    case $opt in
        n)
            name="$OPTARG"
            ;;
        i)
            image="$OPTARG"
            ;;
        p)
            port="$OPTARG"
            ;;
        h)
            echo "Usage: $0 [-n name] [-i image]"
            exit 0
            ;;
    esac
done

shift $((OPTIND - 1))
echo "Name: $name"
echo "Image: $image"
echo "Port: $port"

docker run \
    --volume /$(pwd)/content:/content \
    --publish "$port":22 \
    -e DISPLAY \
    -it \
    --name "$name" \
    "$image" \
    zsh