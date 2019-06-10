"""
    作者：陆震
    功能：输入某年某月某日，判断这一天是这一年的第几天？
    版本：2.0
    日期：10/06/2019
    2.0 新增功能：用列表替换元组
    3.0 新增功能：将月份划分为不同的集合再操作
"""


# 集合：
# Python中的集合set类型同数学中的集合概念一致，即包含0或多个数据项的无序组合
# 由于是无序组合，故没有索引和位置的概念
# 集合中的元素不可重复
# set()函数用于集合的生成，返回结果是一个无重复且排序任意的集合
# 集合通常用于表示成员间的关系、元素去重等
# s - t 或 s.difference(t) 返回在集合s中但不在t中的元素
# s & t 或 s.intersection(t) 返回同时在集合s和t中的元素
# s | t 或 s.union(t) 返回集合s和t中的所有元素
# s ^ t 或 s.symmetric_difference(t) 返回集合s和t中的元素，但不包括同时在其中的元素



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

    # 包含30天的月份的集合
    _30_days_month_set = {4, 6, 9, 11}
    # 包含31天的月份的集合
    _31_days_month_set = {1, 3, 5, 7, 8, 10, 12}

    # 初始化值
    days = 0
    days += day

    for i in range(1, month):
        if i in _30_days_month_set:
            days += 30
        elif i in _31_days_month_set:
            days += 31
        else:
            days += 28

    if is_leap_year(year) and month > 2:
        days += 1

    print('这是{}年的第{}天'.format(year, days))



if __name__ == '__main__':
    main()
