"""
    作者：陆震
    功能：利用递归函数绘制分形树
    版本：1.0
    日期：16/05/2019
"""


# 利用递归函数绘制分形树（fractal tree)
# 分形几何学的基本思想：
# 客观事物具有自相似的层次结构，局部与整体在形态、功能、信息、时间、空间等方面具有统计意义上的相似性
# 称为自相似性
# 自相似性是指局部是整体成比例缩小的性质 

# 引入绘制图形的turtle库
import turtle

def draw_branch(branch_length):
    """
        绘制分形树
    """
    if branch_length >= 5:
        # 绘制右侧树枝
        turtle.pencolor('black')
        turtle.forward(branch_length)
        turtle.right(20)
        draw_branch(branch_length - 5) 
        if branch_length - 5 <= 0: 
            turtle.pencolor('green')
        else:
            turtle.pencolor('black')
        # 绘制左侧树枝
        turtle.left(40)
        draw_branch(branch_length - 5)
        if branch_length - 5 <= 0: 
            turtle.pencolor('green')
        else:
            turtle.pencolor('black')
        # 返回之前的树枝
        turtle.right(20)
        turtle.backward(branch_length)



def main():
    """
        主函数
    """
    turtle.speed(10)
    turtle.left(90)
    draw_branch(50)
    # 点击关闭图形窗口    
    turtle.exitonclick()

if __name__ == '__main__':
    main()
