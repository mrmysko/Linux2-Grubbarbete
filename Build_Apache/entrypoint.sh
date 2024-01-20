#!/bin/bash

# Todo - Add some way to specify that the file should only be run once.

# Run all files in the folder if they are a script (have a bash shebang).
for SCRIPT in /docker.entrypoint/*; do
    if [[ $(file "$SCRIPT" | cut -d ' ' -f 2-3) = "Bourne-Again shell" ]]; then
        /bin/bash -c "$SCRIPT"
    else
        echo "$SCRIPT not a script."
    fi
done

service apache2 start && tail --follow=name /var/log/apache2/error.log