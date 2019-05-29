"""
    作者：陆震
    功能：输入某年某月某日，判断这一天是这一年的第几天？
    版本：1.0
    日期：26/05/2019
"""

import datetime
# 闰年的判断：
# 四年一闰，百年不闰；四百年再闰。

# 元组 (tuple) 是特殊的序列类型，一旦创建就不能修改，使得代码更安全
# 使用逗号和圆括号来表示，访问方式和列表相同，一般用于表达固定数据项、函数多返回值等情况
# 特点：
# 1. 元组中的元素可以是不同类型的
# 2. 元组中各元素存在先后关系，可通过索引访问元组中元素


def main():
    """
       主函数
    """
    input_date_str = input('请输入当前日期(yyyy/mm/dd)：')
    input_date = datetime.datetime.strptime(input_date_str, '%Y/%m/%d')
    print(input_date)

    year = input_date.year
    month = input_date.month
    day = input_date.day

    # 计算当前天数
    days_in_month_tup = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    days = sum(days_in_month_tup[:month-1]) + day

    # 判断平闰年
    if (year % 400 == 0) or ((year % 4 == 0) and (year % 100 != 0)):
        if month > 2:
            days += 1

    print('这是第{}天'.format(days))



if __name__ == '__main__':
    main()
