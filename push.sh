
#!/bin/bash

# 切换到仓库目录（如果你不在该目录下）
# cd yunlongrepo/

# 添加文件到暂存区
git add ipdetect.py linuxjoindomain.sh

# 创建一个新的提交并附上消息
git commit -m "Add shell and python scripts"

# 推送改动到GitHub
git push origin main # 或者 'git push' 如果你已经设置好了默认分支名称

