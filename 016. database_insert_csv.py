# 向数据库手动输入数据不具有扩展性
# 下面向数据库中的表中插入CSV文件中的数据，然后展示表中数据

import csv # 导入csv模块以使用其中的函数读取和分析CSV文件
import sqlite3 
import sys # 使用其中的方法创建简单的本地数据库和数据表，也可以执行SQL查询

# CSV输入文件的路径和文件名
# 使用sys模块在命令行中读取文件的路径和名称
input_file = sys.argv[1]
# 创建SQLite3内存数据库，为本地数据库Suppliers.db创建连接
con = sqlite3.connect('Suppliers.db')
# 创建一个光标，以及一个多行SQL语句，用来创建一个具有5个属性的数据表Suppliers
c = con.cursor()
create_table = """CREATE TABLE IF NOT EXISTS Suppliers
                   (Supplier_Name VARCHAR(20),
                   Invoice_Number VARCHAR(20),
                   Part_Number VARCHAR(20),
                   Cost FLOAT,
                   Purchase_Date DATE);"""

c.execute(create_table)
con.commit()

# 读取CSV文件
# 对输入文件中的每行数据执行一条SQL语句，向Suppliers表中插入数据
# 使用csv模块创建file_reader对象
file_reader = csv.reader(open(input_file, 'r'), delimiter=',')
# 使用next()方法从输入文件中读入第一行，也就是标题行
header = next(file_reader, None)
# 创建一个for循环，在输入文件的所有数据行之间循环
for row in file_reader:
# 创建一个空列表变量data
# 对于输入文件中的每一行，用行中的数据去填充data
    data = []
# for循环在每行数据的各个列之间循环
# 通过append()方法使用输入文件这一行中的所有数据去填充data
    for column_index in range(len(header)):
         data.append(row[column_index])
# 在命令行窗口或终端窗口中打印出追加到data中的这行数据
# 下面这行的缩进是在外部的for循环之下，不是在内部循环之下的
# 所以它是对于输入文件中的每一行来执行，而不是对于输入文件中的每一行和每一列去执行
# 这一行有助于调试脚本，但是一旦确定代码能够正确运行，就可以将这行代码删除或者注释掉，这样在屏幕上不会打印出过多的输出
    print(data)
# 使用光标对象的execute()方法执行一条INSERT语句，将一行数据插入到表Suppliers中
    c.execute("INSERT INTO Suppliers VALUES (?, ?, ?, ?, ?);", data)
con.commit()
print('')

# 查询Suppliers表
output = c.execute("SELECT * FROM Suppliers")
# 将output中的所有行读入变量rows
rows = output.fetchall()
# for循环在rows中的每一行中循环
for row in rows:
    output = []
# 在每一行的各个列之间循环
    for column_index in range(len(row)):
# 将每列中的值追加到一个名为output的列表中
         output.append(str(row[column_index]))
# 确保输出中的每一行都被打印到一个新行中
# 注意缩进，是在行循环中，不是在列循环中
    print(output)


