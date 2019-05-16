"""
    作者：陆震
    功能：五角星的绘制
    版本：2.0
    日期：16/05/2019
    新增功能：加入循环操作绘制重复不同大小的图形
"""


# 引入绘制图形的turtle库
import turtle

def draw_pentagram(size):
    """
        绘制五角星
    """
    # 计数器
    count = 1
    # 绘制五角星
    while count <= 5:
        # 画笔向前移动
        turtle.forward(size)
        # 画笔绘制方向右旋转度
        turtle.right(144)
        count += 1

def main():
    """
        主函数
    """
    # 抬起画笔，之后移动画笔不会绘制形状
    turtle.penup()
    turtle.backward(100)
    # 落下画笔，之后移动画笔会绘制形状
    turtle.pendown()
    # 设置画笔宽度
    turtle.pensize(2)
    # 设置画笔颜色
    turtle.pencolor('red')

    size = 50
    while size <= 200:
        # 调用函数
        draw_pentagram(size)
        size += 20

    # 点击关闭图形窗口    
    turtle.exitonclick()

if __name__ == '__main__':
    main()

