# 批量更新数据表中已有记录
# 使用CSV文件来提供更新特定记录的数据

import csv
import sqlite3
import sys

# CSV输入文件的路径和文件名
input_file = sys.argv[1]
# 创建SQLite3内存数据库
# 创建带有4个属性的sales表
con = sqlite3.connect('update.db')
query = """CREATE TABLE IF NOT EXISTS sales
         (customer VARCHAR(20),
         product VARCHAR(40),
         amount FLOAT,
         date DATE);"""
con.execute(query)
con.commit()
# 向表中插入几行数据
data = [('Richard Lucas', 'Notepad', 2.50, '2014-01-02'),
        ('Jenny Kim', 'Binder', 4.15, '2014-01-15'),
        ('Svetlana Crow', 'Printer', 155.75, '2014-02-03'),
        ('Stephen Randolph', 'Computer', 679.40, '2014-02-20')]
for tuple in data:
    print(tuple)
statement = "INSERT INTO sales VALUES(?, ?, ?, ?)"
con.executemany(statement, data)
con.commit()
# 读取CSV文件并更新特定的行
file_reader = csv.reader(open(input_file, 'r'), delimiter=',')
header = next(file_reader, None)
for row in file_reader:
    data = []
    for column_index in range(len(header)):
        data.append(row[column_index])
    print(data)
    # 在UPDATE语句中，你必须指定想更新哪一条记录和哪一个列属性
    # 这里我们想为一组特定的customer更新amount和date
    # UPDATE语句也需要很多问号占位符表示出查询中的值的位置
    # 这里，查询中的属性从左到右分别是amount,date,customer
    # CSV输入文件中的列从左到右也应该是这个顺序
    con.execute("UPDATE sales SET amount=?, date=? WHERE customer=?;", data)
con.commit()
# 查询sales表
cursor = con.execute("SELECT * FROM sales")
rows = cursor.fetchall()
for row in rows:
    output = []
    for column_index in range(len(row)):
        output.append(str(row[column_index]))
    print(output) # 打印出每一行，并使用一个逗号分割每一列                                                                                                                                                                                                                                                                                                 
