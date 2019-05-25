"""
    作者：陆震
    功能：52周存钱挑战
    版本：3.0
    日期：22/05/2019
    3.0 新增功能：使用for循环直接计数
"""


# math库
import math
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


def main():
    """
        主函数
    """
    money_per_week = 10  # 每周存入的金额，初始为10元
    # i = 1  # 周数，初始为1周
    increase_money = 10  # 每周递增的金额
    total_weeks = 52  # 总共的周数

    money_list = [] # 记录每周存款数的列表

    for i in range(total_weeks):
        # 存钱操作
        # saving += money_per_week
        money_list.append(money_per_week)  # 将元素添加到列表末尾
        # 对列表元素排序 list.sort()
        # 对列表元素逆序 list.reverse()
        # 返回第一次出现元素x的索引值 list.index(x)
        # 在位置i前插入新元素x list.insert(i, x)
        # 返回元素x在列表中的数量 list.count(x)
        # 删除列表中第一次出现的元素x list.remove()
        # 取出列表中i位置上的元素，并将其从列表中删除 list.pop(i)

        saving = math.fsum(money_list)  # 对集合内的元素求和

        print('第{0}周，存入{2}元，现有存款总共是{1}元'.format(i + 1, saving, money_per_week))
        # 更新下一周的存钱操作
        # i += 1  # while循环需要记录循环次数
        money_per_week += increase_money


if __name__ == '__main__':
    main()
