"""
    作者：陆震
    功能：52周存钱挑战
    版本：1.0
    日期：22/05/2019
"""


# 52周存钱法，即52周阶梯式存钱法，是国际上非常流行的存钱方法
# 按照52周存钱法，存钱的人必须在一年52周内，每周递存10元，这样一年下来会有13780元

def main():
    """
        主函数
    """
    money_per_week = 10 # 每周存入的金额，初始为10元
    i = 1               # 周数，初始为1周
    increase_money = 10 # 每周递增的金额
    total_weeks = 52    # 总共的周数
    saving = 0          # 账户累计总金额

    while i <= total_weeks:
        # 存钱操作
        saving += money_per_week
        print('第{0}周，存入{2}元，现有存款总共是{1}元'.format(i, saving, money_per_week))
        # 更新下一周的存钱操作
        i += 1
        money_per_week += increase_money
        
    


if __name__ == '__main__':
    main()
