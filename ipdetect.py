import os

# 设置起始和结束的IP地址
start_ip = 101
end_ip = 120
base_ip = "10.12.24."

# 打开一个文件以保存结果
with open("ping_results.txt", "w") as file:
    # 遍历IP地址范围
    for i in range(start_ip, end_ip + 1):
        # 构造完整的IP地址
        ip = f"{base_ip}{i}"
        # 执行ping命令
        response = os.system(f"ping -c 1 {ip}")
        
        # 根据响应码判断结果，并写入文件
        if response == 0:
            file.write(f"IP address {ip} is reachable.\n")
            print(f"IP address {ip} is reachable.")
        else:
            file.write(f"IP address {ip} is unreachable.\n")
            print(f"IP address {ip} is unreachable.")

# 结果已经保存到当前目录下的 ping_results.txt 文件里

