name=""
image="ubuntu2004_zsh:latest"
port=30022
shell="zsh"

while getopts ":n:i:hp:s:" opt; do
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
        s)
            shell="$OPTARG"
            ;;
        h)
            echo "Usage: $0 [-n name] [-i image] [-p port] [-s shell]"
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
    --net "host"\
    "$image" \
    "$shell"
