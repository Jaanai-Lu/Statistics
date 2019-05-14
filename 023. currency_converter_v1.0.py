rmb_str_value = input('请输入人民币（CNY)金额: ')
rmb_value = eval(rmb_str_value)
usd_vs_rmb = 6.77
usd_value = rmb_value / usd_vs_rmb
print('美元（USD）金额是： ', usd_value)
