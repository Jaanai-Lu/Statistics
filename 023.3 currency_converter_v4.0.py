"""
   作者：陆震
   功能：汇率兑换
   版本：2.0
   日期：15/05/2019
   2.0 新增功能：根据输入判断是人民币还是美元，进行相应的转换计算
   3.0 新增功能：程序可以一直运行，直到用户选择退出
   4.0 新增功能：将汇率兑换功能封装到函数中
"""

# 函数：将特定功能代码编写在一个函数里，便于阅读和复用
# 对一组表达特定功能表达式的封装，使程序模块化
def convert_currency(im, er):
    """
        汇率兑换函数
    """
    out = im * er
    return out


# 汇率（常量不改变，大写放开头）
USD_VS_RMB = 6.77

# 带单位的货币的输入
currency_str_value = input('请输入带单位的货币金额: ')

# 文本在程序中通过字符串（string）类型表示，由两个双引号或单引号括起来表示
# 索引/访问方式：正向索引、反向索引，区间索引
# 获取货币单位
unit = currency_str_value[-3:]
# 分支语句：控制程序的语句，根据判断条件选择程序的执行路径
if unit == 'CNY':
    exchange_rate = 1 / USD_VS_RMB
elif unit == 'USD':
    exchange_rate = USD_VS_RMB
else:
    exchange_rate = -1
   
if exchange_rate != -1:
    in_money = eval(currency_str_value[:-3])
    # 调用函数，参数（实际参数和形式参数）一一对应赋值
    out_money = convert_currency(in_money, exchange_rate)
    print('转换后的金额', out_money)
else:
    print('不支持该种货币')
   
