import sqlite3

# 创建SQLite3内存数据库
# 创建带有4个属性的sales表

# 首先必须创建一个代表数据库的连接对象
con = sqlite3.connect('my_databese.db') # 连接对象con代表数据库，在桌面上创建了一个数据库
# 使用3个引号创建一个多行字符串，为SQL命令
# 在数据库中创建一个名为sales的表，有4个属性：customer、product、amount、date
# customer VARCHAR(20), 变长字符型字段，最大字符数为20
# product VARCHAR(40), 变长字符型字段，最大字符数为40
# amount FLOAT, 浮点数型字段
# date DATE # 日期型字段
query = """CREATE TABLE sales
              (customer VARCHAR(20),
              product VARCHAR(40),
              amount FLOAT,
              date DATE);"""
# 使用连接对象的execute()方法执行包含在query中的SQL命令，创建sales表
con.execute(query)
# 使用连接对象的commit()方法将修改提交（保存）到数据库
# 当对数据库作出修改时，必须使用commit()保存修改到数据库
con.commit()

# 在表中插入几行数据
# 创建一个元组列表，列表中每个元素都是一个包含4个值的元组：3个字符串和1个浮点数，且按位置对应表sales的4个属性
# 每个元组即表中的一行数据
data = [('Richard Lucas', 'Notepad', 2.50, '2014-01-02'),
        ('Jenny Kim', 'Binder', 4.15, '2014=01=15'),
        ('Svetlana Crow', 'Printer', 155.75, '2014-02-03'),
        ('Stephen Randolph', 'Computer', 679.40, '2014-02-20')]

# 创建一个字符串，因为这个字符串可以写在一行中，所以使用一对双引号
# INSERT语句，可以将data中的数据行插入sales表
# 问号在这里作为占位符，表示我想在SQL命令中使用的值
statement = "INSERT INTO sales VALUES(?, ?, ?, ?)"
# 提供一个包含4个值的元组，元组中的值会按位置替换到SQL命令中
# 使用executemany()方法为data中的每个数据元组执行statement中的SQL命令，高效
con.executemany(statement, data)
# 保存修改
con.commit()

# 查询sales表，从数据库的表中提取数据
# 使用execute()执行一条SQL命令
cursor = con.execute("SELECT * FROM sales")
# 因为经常需要查看或处理在execute()中运行的SQL命令的全部结果，通常使用fetchall()取出（返回）结果集中的所有行
# rows是一个元组列表
rows = cursor.fetchall()

# 计算查询结果中的行数
row_counter = 0
# 创建了一个for循环在rows的行中迭代，对于rows中的每一行，使row_counter增加1
for row in rows:
    print(row)
    row_counter += 1
print('Number of rows: %d' % (row_counter))
