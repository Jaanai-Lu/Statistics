"""
    作者：陆震
    功能：BMR计算器
    版本：1.0
    日期：16/05/2019
"""


# 基础代谢率（BMR: Basal Metabolic Rate）：
# 在安静状态下（通常为静卧状态）消耗的最低热量，人的其他活动都建立在这个基础上
# 计算公式：
# 男：BMR = 13.7*体重（kg）+5.0*身高（cm）-（6.8*年龄）+ 66
# 女：BMR = 9.6*体重（kg）+1.8*身高（cm）-（4.7*年龄）+ 655


def main():
    """
        主函数
    """
    # 性别
    gender = '男'
    # 体重(kg)
    weight = 70
    # 身高（cm）
    height = 180
    # 年龄
    age = 25

    if gender == '男':
        # 男性
        bmr = 13.7 * weight + 5.0 * height - 6.8 * age + 66
    elif gender == '女':
        # 女性
        bmr = 9.6 * weight + 1.8 * height - 4.7 * age + 655
    else:
        bmr = -1
    if bmr != -1:
        print('基础代谢率（大卡）：', bmr)
    else:
        print('暂不支持该性别')

if __name__ == '__main__':
    main()
