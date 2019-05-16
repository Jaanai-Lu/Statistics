"""
    作者：陆震
    功能：五角星的绘制
    版本：3.0
    日期：16/05/2019
    新增功能：加入循环操作绘制重复不同大小的图形
    新增功能：使用迭代函数绘制重复不同大小的图形
"""


# 递归：函数定义中调用函数自身的方式称为递归
# 每次函数调用时，函数参数会临时存储，返回计算结果
# 达到终止条件时，各函数逐层结束运算，返回计算结果
# 要注意终止条件的构建，否则迭代无法正常返回结果

# 引入绘制图形的turtle库
import turtle

def draw_recursive_pentagram(size):
    """
        迭代绘制五角星
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
    # 五角星绘制完成，更新参数size，调用自身函数形成递归函数
    size += 20
    if size <= 200:
        draw_recursive_pentagram(size)

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
    draw_recursive_pentagram(size)
    
    # 点击关闭图形窗口    
    turtle.exitonclick()

if __name__ == '__main__':
    main()
