for D in repos/*; do
    if [ -d "${D}" ]; then
        if test -f "${D}/package.json"; then
            echo "Building dist files for ${D}"
            (cd ${D} && npm install && npm run build)
        fi
    fi
done