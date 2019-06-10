"""
    作者：陆震
    功能：输入某年某月某日，判断这一天是这一年的第几天？
    版本：2.0
    日期：26/05/2019
    2.0 新增功能：用列表替换元组
"""

import datetime
# 闰年的判断：
# 四年一闰，百年不闰；四百年再闰。

# 元组 (tuple) 是特殊的序列类型，一旦创建就不能修改，使得代码更安全
# 使用逗号和圆括号来表示，访问方式和列表相同，一般用于表达固定数据项、函数多返回值等情况
# 特点：
# 1. 元组中的元素可以是不同类型的
# 2. 元组中各元素存在先后关系，可通过索引访问元组中元素

# 元组通常是由不同的数据组成，列表通常是由相同类型的数据组成
# 元组表示的是结构，列表表示的是顺序

def is_leap_year(year):
    """
        判断year平闰年
        是，返回True
        否，返回False
    :param year:
    :return:
    """
    is_leap = False
    if (year % 400 == 0) or ((year % 4 == 0) and (year % 100 != 0)):
        is_leap = True

    return is_leap


def main():
    """
       主函数
    """
    input_date_str = input('请输入当前日期(yyyy/mm/dd)：')
    input_date = datetime.datetime.strptime(input_date_str, '%Y/%m/%d')


    year = input_date.year
    month = input_date.month
    day = input_date.day

    # 计算当前天数
    days_in_month_list = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    # 列表可以更换元素
    if is_leap_year(year):
        days_in_month_list[1] = 29
    days = sum(days_in_month_list[:month-1]) + day

    # # 判断平闰年
    # if month > 2 and is_leap_year(year):
    #     days += 1

    print('这是{}年的第{}天'.format(year, days))



if __name__ == '__main__':
    main()
