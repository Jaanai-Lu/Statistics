# 内省（内部检查）Excel文件，获取其中所有工作表的信息（工作表的数目，每个工作表中数据类型和数据量

import sys
# 导入xlrd模块的open_workbook函数来读取和分析Excel文件
from xlrd import open_workbook
input_file = sys.argv[1]
# 打开一个Excel文件，并赋给一个名为workbook的对象
# workbook对象中包含了文件中所有可用的信息，可以使用这个对象从文件中得到单独的工作表
workbook = open_workbook(input_file)
# 打印出文件中工作表的数量
print('Number of worksheets:', workbook.nsheets)
# 在文件的所有工作表之间迭代，sheets方法可以识别出文件中所有的工作表
for worksheet in workbook.sheets():
    # 使用name属性确定每个工作表的名称
    # 使用nrows和ncols属性确定每个工作表中行与列的数量
    print("Worksheet name:", worksheet.name, "\tRows:",\
        worksheet.nrows, "\tColumns:", worksheet.ncols)
