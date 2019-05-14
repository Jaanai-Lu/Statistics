# 处理单个工作表
# 读写Excel文件
import sys
from xlrd import open_workbook
# 导入xlwt模块的Workbook对象
from xlwt import Workbook

input_file = sys.argv[1]
output_file = sys.argv[2]

# 实例化一个xlwt Workbook对象，以便将结果写入用于输出的Excel文件
output_workbook = Workbook()
# 使用xlwt的add_sheet函数为输出文件添加一个工作表jan_2013_output
output_worksheet = output_workbook.add_sheet('jan_2013_output')
# 使用open_workbook函数打开用于输入的文件，并将结果赋给一个workbook对象
with open_workbook(input_file) as workbook:
    # 使用这个workbook对象的sheet_by_name函数引用名称为january_2013的工作表
    worksheet = workbook.sheet_by_name('january_2013')
    # 下面两行创建了行和列索引值上的for循环语句，在工作表的每行和每列之间迭代
    for row_index in range(worksheet.nrows):
        for column_index in range(worksheet.ncols):
            # 使用xlwt的write函数和行与列的索引将每个单元格的值写入输出文件的工作表
            output_worksheet.write(row_index, column_index, \
                worksheet.cell_value(row_index, column_index))
# 保存并关闭输出文件
output_workbook.save(output_file)
# 你可能已经发现，Excel将日期和时间保存为浮点数
# 这个浮点数代表从1900年1月1日开始经过的日期数，加上一个24小时的小数部分
# 因此，Purchase Date列的数值代表日期，但是没有格式化为日期的形式
# xlrd包提供了其他函数来格式化日期值
# 下一个示例会格式化日期数据
