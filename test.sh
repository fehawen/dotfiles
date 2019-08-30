#!/bin/bash

# tee ./test.txt << EOF
# 	line 1,
# 	line 2,
# 	line 3,
# 	line 4 line
# EOF

content="

Hello World
Hello World
Hello World

"

echo $content >> ./test.sh
Hello World Hello World Hello World
