#!/bin/bash
cd /usr/local/bin && echo -e "#!/bin/bash\n/usr/bin/osascript -e \"display notification \\\"\$*\\\" with title \\\"\$*\\\" subtitle \\\"\$*\\\"\"" > notify && chmod +x notify; cd -
