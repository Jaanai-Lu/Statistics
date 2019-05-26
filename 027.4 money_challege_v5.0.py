"""
    作者：陆震
    功能：52周存钱挑战
    版本：5.0
    日期：22/05/2019
    5.0 新增功能：根据用户输入的日期，判断是一年中的第几周，然后输出相应的存款金额
"""


# math库
import math
import datetime

# 圆周率 math.pi
# 对x向上取整 math.ceil(x)
# 对x向下取整 math.floor(x)
# x的y次方 math.pow(x, y)
# x的平方根 math.sqrt(x)


# 52周存钱法，即52周阶梯式存钱法，是国际上非常流行的存钱方法
# 按照52周存钱法，存钱的人必须在一年52周内，每周递存10元，这样一年下来会有13780元


# for循环：使用for语句可以循环遍历整个序列的内容
# 循环变量x在每次循环时，被赋值成对应的元素内容
# 与while循环的区别：for循环的次数固定，即所遍历的序列长度，而while为无限循环
# range(n)返回一个可迭代的对象，从0开始计数，为range类型，list(range(n))将迭代类型转换为列表类型

# 全局变量
saving = 0


def save_money_in_n_weeks(total_weeks, money_per_week, increase_money):
    """
        计算n周内的存款金额
    """
    money_list = []  # 记录每周存款数的列表
    saving_list = []  # 记录每周存款总金额的列表
    global saving  # 声明此处函数里的saving是全局变量而非局部变量

    for i in range(total_weeks):
        # 存钱操作
        # saving += money_per_week
        money_list.append(money_per_week)  # 将元素添加到列表末尾
        saving_list.append(saving)
        # 对列表元素排序 list.sort()
        # 对列表元素逆序 list.reverse()
        # 返回第一次出现元素x的索引值 list.index(x)
        # 在位置i前插入新元素x list.insert(i, x)
        # 返回元素x在列表中的数量 list.count(x)
        # 删除列表中第一次出现的元素x list.remove()
        # 取出列表中i位置上的元素，并将其从列表中删除 list.pop(i)

        saving = math.fsum(money_list)  # 对集合内的元素求和
        # print('第{0}周，存入{2}元，现有存款总共是{1}元'.format(i + 1, saving, money_per_week))
        # 更新下一周的存钱操作
        # i += 1  # while循环需要记录循环次数
        money_per_week += increase_money
    return saving_list

def main():
    """
        主函数
    """
    money_per_week = float(input('请输入每周存入的金额：'))
    # i = 1  # 周数，初始为1周
    increase_money = float(input('请输入每周递增的金额：'))
    total_weeks = int(input('请输入总共的周数：'))  # 总共的周数
    # 函数的参数传递：函数通过参数与调用程序传递信息
    # 变量的作用范围：
    # 1.局部：函数内的变量作用范围只在函数内
    # 2.全局：函数外的变量，在所有函数中都能使用
    # 函数的形参只接收实参的值，给形参赋值并不影响实参
    # global saving
    saving_list = save_money_in_n_weeks(total_weeks, money_per_week, increase_money)
    data_str = input('请输入当前日期(yyyy/mm/dd)：')
    input_date = datetime.datetime.strptime(data_str, '%Y/%m/%d')

    # datetime库：处理时间的标准函数库datetime
    # datetime.datetime.now()获取当前日期和时间
    # 字符串转换成datetime，使用datetime.strptime()解析时间字符串，如datetime.datetime.strptime(a, "%Y/%m/%d")
    # isocalendar()返回年，周数及周几
    # datetime转换为字符串，使用strftime()格式化datetime为字符串，如datetime.datetime.strftime(a, '%d%m%Y')
    week_num = input_date.isocalendar()[1]
    print('第{}周的存款总金额是{}元'.format(week_num, saving_list[week_num - 1]))


if __name__ == '__main__':
    main()
