"""
    作者：陆震
    功能：五角星的绘制
    版本：1.0
    日期：16/05/2019
"""


# 引入绘制图形的turtle库
import turtle



def main():
    """
        主函数
    """
    # 计数器
    count = 1

    while count <= 5:
        # 画笔向前移动
        turtle.forward(300)
        # 画笔绘制方向右旋转度
        turtle.right(144)
        count += 1
    # 点击关闭图形窗口    
    turtle.exitonclick()

if __name__ == '__main__':
    main()

