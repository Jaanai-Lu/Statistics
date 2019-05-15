"""
   作者：陆震
   功能：汇率兑换
   版本：2.0
   日期：15/05/2019
   新增功能：根据输入判断是人民币还是美元，进行相应的转换计算
"""

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
   # 输入的是人民币
   # 从字符串中拿到子字符串
   rmb_str_value = currency_str_value[:-3]
   # 将字符串转换为数字
   rmb_value = eval(rmb_str_value)
   # 汇率的计算
   usd_value = rmb_value / USD_VS_RMB
   # 输出结果
   print('美元（USD）金额是： ', usd_value)
elif unit == 'USD':
   # 输入的是美元
   # 从字符串中拿到子字符串
   usd_str_value = currency_str_value[:-3]
   # 将字符串转换为数字
   usd_value = eval(usd_str_value)
   # 汇率的计算
   rmb_value = usd_value * USD_VS_RMB
   # 输出结果
   print('人民币（CNY）金额是： ', rmb_value) 
else:
   # 其他情况
   print('目前版本尚不支持该种货币！')
