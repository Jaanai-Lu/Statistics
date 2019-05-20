"""
    作者：陆震
    功能：BMR计算器
    版本：3.0
    日期：20/05/2019
    新增功能：用户可以在一行输入所有信息，实现带单位的信息输出
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
    y_or_n = input('是否退出程序(y/n)?')

    while y_or_n == 'n':
        print('请输入以下信息，用空格分隔')
        input_string = input('性别 体重(kg) 身高(cm) 年龄:')
        # input_string.find(' ') # 寻找空格，另一方法
        string_list = input_string.split(' ') # 字符串分割
        gender = string_list[0]
        weight = float(string_list[1])
        height = float(string_list[2])
        age = int(string_list[3])

        if gender == '男':
            # 男性
            bmr = 13.7 * weight + 5.0 * height - 6.8 * age + 66
        elif gender == '女':
            # 女性
            bmr = 9.6 * weight + 1.8 * height - 4.7 * age + 655
        else:
            bmr = -1
        if bmr != -1:
            # 字符串格式化输出，使用 {} 占位
            # 重复输出时可以使用数字标记顺序
            print('您的性别：{1}，体重：{0}（kg），身高：{2}（cm），年龄：{3}'.format(weight, gender, height, age))
            print('您的基础代谢率为：{}(大卡)'.format(bmr)) 
        else:
            print('暂不支持该性别')
        print() # 参数为空时，输出一行空行
        y_or_n = input('是否退出程序(y/n)?')

if __name__ == '__main__':
    main()
