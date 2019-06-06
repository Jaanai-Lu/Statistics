# lect004
# 陆震
# 2019-06-05

# 数值和字符处理函数
# R中作为数据处理基石的函数，可分为数值(数学、统计、概率)函数和字符处理函数

# 数学函数：
# abs(x) 求绝对值，如 abs(-4)返回值为4
# sqrt(x) 求平方根，如 sqrt(25)返回值为5，与25**0.5等价
# ceiling(x) 求不小于x的最小整数，如 ceiling(3.475)返回值为4
# floor(x) 求不大于x的最大整数，如 floor(3.475)返回值为3
# trunc(x) 向0的方向截取的x中的整数部分，如 trunc(5.99)返回值为5
# round(x, digits=n) 将x舍入为指定位的小数，如 round(3.475, digits=2)返回值为3.48
# signif(x, digits=n) 将x舍入为指定的有效数字位数，如 signif(3.475, digits=2)返回值为3.5
# cos(x)、sin(x)、tan(x) 余弦、正弦和正切，如 cos(2)返回值为-0.416
# acos(x)、asin(x)、atan(x) 反余弦、反正弦和反正切，如 acos(-0.416)返回值为2
# log(x, base=n) 对x取以n为底的对数
# log(x) 自然对数，如log(10)返回值为2.3026
# log10(x) 常用对数(以10为底)，如 log10(10)返回值为1
# exp(x) 指数函数，如 exp(2.3026)返回值为10
# 当这些函数被用于数值向量、矩阵或数据框时，它们会作用域每一个独立的值
# 如 sqrt(c(4, 16, 25))返回值为c(2, 4, 5)

# 统计函数：
# mean(x) 平均数，如 mean(c(1, 2, 3, 4))返回值为2.5
# mean(x, trim=0.05, na.rm=TRUE) 截尾平均数，即丢弃了最大5%和最小5%的数据和所有缺失值后的算术平均数
# median(x) 中位数，如 median(c(1, 2, 3, 4))返回值为2.5
# sd(x) 标准差，如 sd(c(1, 2, 3, 4))返回值为1.29
# var(x) 方差，如 var(c(1, 2, 3, 4))返回值为1.67
# mad(x) 绝对中位差(median absolute deviation)，如 mad(c(1, 2, 3, 4))返回值为1.48
# quantile(x, probs) 求分位数，其中x为待求分位数的数值型向量，probs为一个由[0, 1]之间概率值组成的数值向量
# 如 quantile(x, c(.3, .84)) -> y 求x的30%和84%分位点
# range(x) 求值域，如 c(1, 2, 3, 4) -> x range(x)返回值为c(1, 4) diff(range(x))返回值为3
# sum(x) 求和，如 sum(c(1, 2, 3, 4))返回值为10
# diff(x, lag=n) 滞后差分，lag用以指定滞后几项，默认为1
# 如 c(1, 5, 23, 29) -> x diff(x)返回值为c(4, 18, 6) 
# min(x) 求最小值，如 min(c(1, 2, 3, 4))返回值为1
# max(x) 求最大值，如 max(c(1, 2, 3, 4))返回值为4
# scale(x, center=TRUE, scale=TRUE)
# 为数据对象x按列进行中心化(center=TRUE)或标准化(center=TRUE, scale=TRUE)
# scale(mydata) -> newdata 默认情况下，函数scale()对矩阵或数据框的指定列进行均值为0、标准差为1的标准化
# scale(mydata)*SD + M -> newdata 对每一列进行任意均值和标准差的标准化
# 其中M是想要的均值，SD是想要的标准差
# transform(mydata, myvar=scale(myvar)*10+50) -> newdata # 对指定列而非整个矩阵或数据框进行标准化
# 将变量myvar标准化为均值为50、标准差为10的变量
# 注意：在非数值型的列上使用scale()函数会报错

# 均值和标准差的计算
c(1, 2, 3, 4, 5, 6, 7, 8) -> x
# 简洁的方式
mean(x)
sd(x)
# 冗长的方式
length(x) -> n # 返回x中元素数量
sum(x) / n -> meanx
sum((x - meanx)**2) -> css # x中每个元素减去meanx后求平方
sqrt(css / (n - 1)) -> sdx
# R中公式的写法和类似MATLAB的矩阵运算语言有许多共同之处

# 概率函数：通常用来生成服从已知特征的概率分布的模拟数据，以及在用户编写的统计函数中计算概率值

# 概率分布：
# beta Beta分布
# binom 二项分布
# cauchy 柯西分布
# chisq (非中心)卡方分布
# exp 指数分布
# f F分布
# gamma Gamma分布
# geom 几何分布
# hyper 超几何分布
# lnorm 对数正态分布
# logis Logistic分布
# multinom 多项分布
# nbinom 负二项分布
# norm 正态分布
# pois 泊松分布
# signrank Wilcoxon符号秩分布
# t t分布
# unif 均匀分布
# wilcox Wilcoxon秩和分布
# weibull Weibull分布

# 在R中，概率函数形如 [dpqr]distribution_abbreviation()
# 其中，第一个字母表示其所指分布的某一方面：
# d为密度函数(density)
# p为分布函数(distribution function)，某值左侧曲线下面积
# q为分位数函数(quantile function)
# r生成随机数(随机偏差)

# 正态分布有关函数：
# 如果不指定一个均值和一个标准差，函数将假定其为标准正态分布(均值为0，标准差为1)
# 在区间[-3, 3]上绘制标准正态曲线：
pretty(c(-3, 3), 30) -> x # 创建美观的分割点，通过选取31个等间距的取整值，将连续型变量分割为30个区间
dnorm(x) -> y # 密度函数
plot(x, y,
     type = 'l',
     xlab = 'Normal Deviate',
     ylab = 'Density',
     yaxs = 'i')
# 位于z=1.96左侧的标准正态曲线下方面积是多少？
pnorm(1.96) # 分布函数，返回值为0.975
# 均值为500，标准差为100的正态分布的0.9(注：面积)分位点值是多少？
qnorm(.9, mean = 500, sd=100)
# 生成50个均值为50，标准差为10的正态随机数
rnorm(50, mean = 50, sd=10)

# 《卫生统计学》73页例4-12
# 某地1986年120名8岁男孩身高均属为123.02cm，标准差为4.79cm
1 - pnorm(130, mean = 123.02, sd=4.79) # 身高在130cm以上者占男孩总数的百分比
pnorm(120, mean = 123.02, sd=4.79) -> a
pnorm(128, mean = 123.02, sd=4.79) -> b
b - a # 身高在120～128cm者占男孩总数的百分比
qnorm(.1, mean = 123.02, sd=4.79) -> c
qnorm(.9, mean = 123.02, sd=4.79) -> d
# 80%的男孩身高集中在c~d之间

# 设定随机数种子
# 每次生成伪随机数时，函数都会使用一个不同的种子，因此会产生不同的结果
# 可通过函数set.seed()显式指定种子，让结果可重现(reproducible)
set.seed(1234) # 手动设定种子
runif(5) # 生成0到1区间上服从均匀分布的伪随机数

# 生成多元正态数据
# 在模拟研究和蒙特卡洛方法中，经常需要获取来自给定均值向量和协方差阵的多元正态分布的数据
# MASS包中的mvrnorm()函数可以轻松实现, mvrnorm(n, mean, sigma)
# 其中，n是想要的样本大小，mean为均值向量，sigma是方差-协方差矩阵(或相关矩阵)

# 从三元正态分布中抽取500个观测：
library(MASS)
options(digits = 3) # options()函数显示或设置当前选项，这里数字将被格式化，限定为小数点后保留三位有效数字
set.seed(1234)
c(230.7, 146.7, 3.6) -> mean # 指定均值向量
matrix(c(15360.8, 6721.2, -47.1,
         6721.2, 4700.9, -16.5,
         -47.1, -16.5, 0.3),
       nrow = 3, ncol = 3) -> sigma # 默认按列填充，指定方差-协方差矩阵
# 注意：由于相关矩阵同时也是协方差阵，所以可以直接指定相关关系的结构
mvrnorm(500, mean, sigma) -> mydata # 生成500个伪随机观测
as.data.frame(mydata) -> mydata
c('y', 'x1', 'x2') -> names(mydata) # 指定变量名称
dim(mydata) # 查看维度，500个观测，3个变量
head(mydata, n=10) # 查看前10个观测

# 字符处理函数：
# 数学和统计函数用来处理数值型数据
# 而字符处理函数可从文本型数据中抽取信息，或者为打印输出和生成报告重设文本的格式

# nchar(x) 计算x中的字符数量
# 如 c('ab', 'cde', 'fghij') -> x length(x)返回对象x的长度值为3 nchar(x[3])返回值为5

# substr(x, start, stop) 提取或替换一个字符向量中的子串
'abcdef' -> x
substr(x, 2, 4) # 返回值为"bcd"
c('ab45', 'cde12', 'fghij4') -> x
substr(x, 2, 3) # 返回值为"b4" "de" "gh"

# grep(pattern, x, ignore, case=FALSE, fixed=FALSE) 在x中搜索某种模式，返回值为匹配的下标
# 若fixed=FALSE，则pattern为一个正则表达式；若fixed=TRUE，则pattern为一个文本字符串
grep('A', c('b', 'A', 'a', 'c'), fixed = TRUE) # 返回值为2

# sub(pattern, replacement, x, ignore.case=FALSE, fixed=FALSE) 
# 在x中搜索pattern，并以文本replacement将其替换
# 若fixed=FALSE，则pattern为一个正则表达式；若fixed=TRUE，则pattern为一个文本字符串
sub('\\s', '.', 'Hello There') # 返回值为"Hello.There"
# 注意：'\\s'是一个用来查找空白的正则表达式，使用'\\s'而非'\'的原因是，后者是R中的转义符

# strsplit(x, split, fixed=FALSE) 在split处分割字符向量x中的元素
# 若fixed=FALSE，则pattern为一个正则表达式；若fixed=TRUE，则pattern为一个文本字符串
strsplit('abc', '') -> y # 返回一个含有1个成分、3个元素的列表，包含的内容为"a" "b" "c"
unlist(y)[2]
sapply(y, '[', 2) # '[' 是一个可以提取某个对象的一部分的函数
# 上述俩者都会返回"b"

# paste(..., sep='') 连接字符串，分隔符为sep
paste('x', 1:3, sep = '') # 返回值为c("x1", "x2", "x3")
paste('x', 1:3, sep = 'M') # 返回值为c("xM1", "xM2", "xM3")
paste('x', 1:3, sep = '-') # 返回值为c("x-1", "x-2", "x-3")
paste('Today is', date()) # 返回值为 Today is Wed Jun  5 16:24:07 2019
paste('Today is', Sys.Date()) # 返回值为 Today is 2019-06-05

# toupper(x) 大写转换 
toupper('abc') # 返回值为"ABC"

# tolower(x) 下写转换
tolower('ABC') # 返回值为"abc"

# 注意：
# grep()、sub()和strsplit()能够搜索某个文本字符串(fixed=TRUE)或某个正则表达式(fixed=FALSE，默认为FALSE)
# 正则表达式regular expression为文本模式的匹配提供了一套清洗简练的语法，如
# ^[hc]?at 可匹配任意以0个或1个h或c开头、后接at的字符串
# 因而此表达式可匹配hat、cat和at，但不可匹配bat

# 其他实用函数：
# length(x) 对象x的长度
# seq(from, to, by) 生成一个序列
seq(1, 10, 2) -> indices
indices
# rep(x, n) 将x重复n次
rep(1:3, 2) # 返回值为c(1, 2, 3, 1, 2, 3)
# cut(x, n) 将连续型变量x分割为有着n个水平的因子，使用选项ordered_result = TRUE可创建一个有序型因子
# pretty(x, n) 创建美观的分割点，通过选取n+1个等间距的取整值，将一个连续型变量x分割为n个区间，绘图中常用
# cat(..., file='myfile', append=FALSE) 连接...中的对象，并将其输出到屏幕上或文件中(如果声明了一个的话)
c('Jane') -> firstname
cat('Hello', firstname, '\n') # 返回 'Hello Jane'，\n 表示新行
# \t 为制表符，\' 为单引号，\b 为退格(可查看 ?Quotes)
'Bob' -> name
cat('Hello', name, '\b.\n', 'Isn\'t R', '\t', 'GREAT?\n')
# 返回：
# Hello Bob.
#  Isn't R 	 GREAT?
# 注意：第二行缩进了一个空格，当cat输出连接后的对象时，它会将每一个对象都用空格分开
# 这就是在句号之前使用退格转义符的原因
cat('Hello', name, '.\n', 'Isn\'t R', '\t', 'GREAT?\n')
# 返回：
# Hello Bob .
#  Isn't R 	 GREAT?
cat('Hello', name, '\b.\n', '\bIsn\'t R', '\t', 'GREAT?\n')
# 返回：
# Hello Bob .
# Isn't R 	 GREAT?

# R函数可应用到一系列的数据对象上，包括标量、向量、矩阵、数组和数据框
c(1.234, 5.566) -> a
round(a, 2)
round(a)
matrix(runif(12), ncol = 3) -> b
b
mean(b) # 注意：对矩阵b求均值的结果为一个标量，mean()求得的是矩阵中全部元素的均值
# R提供了一个apply()函数，可将一个任意函数应用到矩阵、数组、数据框的任何维度上
# apply(x, MARGIN, FUN, ...)
# 其中，x为数据对象，MARGIN是维度的下标，FUN是用户指定的函数，可为任意R函数，包括自行编写的函数
# ...包括了任何想传递给FUN的参数
# 在矩阵或数据框中，MARGIN=1表示行，MARGIN=2表示列

# apply()可把函数应用到数组的某个维度上
# 而lapply()和sapply()则可将函数应用到列表list上

# 将一个函数应用到矩阵的所有行(列)
matrix(rnorm(30), nrow = 6) -> mydata # 生成一个包含正态随机数的6*5矩阵
mydata
apply(mydata, 1, mean) # 求矩阵各行的均值
mean(mydata)
apply(mydata, 2, mean) # 求矩阵各列的均值
apply(mydata, 2, mean, trim=.2) # 求矩阵各列的截尾均值(最高和最低20%的值均被忽略，截尾均值基于中间60%数据)


options(digits = 2)
c('John Davis', 'Angela Williams', 'Bullwinkle Moose', 'David Jones',
  'Janice Markhammer', 'Cheryl Cushing', 'Reuven Ytzrhak', 'Greg Knox',
  'Joel England', 'Mary Rayburn') -> Student
c(502, 600, 412, 358, 495, 512, 410, 625, 573, 522) -> Math
c(95, 99, 80, 82, 75, 85, 80, 95, 89, 86) -> Science
c(25, 22, 18, 15, 20, 28, 15, 30, 27, 18) -> English
data.frame(Student, Math, Science, English, stringsAsFactors = FALSE) -> roster 

# 将学生的各科成绩组合为单一的成绩衡量指标：
# 由于各科分值不同(均值和标准差差别很大)，在组合之前需要先让它们变得可以比较
# 一种方法是将变量进行标准化，这样每科成绩都是用单位标准差来表示，而不是以原来的尺度来表示
# 这个过程可以使用scale()函数实现
scale(roster[, 2:4]) -> z
apply(z, 1, mean) -> score # 将学生的各科成绩组合为单一的成绩衡量指标
cbind(roster, score) -> new_roster

quantile(score, c(.8, .6, .4, .2)) -> y # 求学生综合得分的分位数
within(new_roster, {
  NA -> grade
  'A' -> grade[score >= y[1]]
  'B' -> grade[score < y[1] & score >= y[2]]
  'C' -> grade[score < y[2] & score >= y[3]]
  'D' -> grade[score < y[3] & score >= y[4]]
  'F' -> grade[score < y[4]]
  factor(grade, ordered = TRUE) -> grade
}) -> new_roster # 基于score重编码，给出A到F的评分
# 注意：within()函数里赋值的变量都会加到数据集里，无关变量务必放出去！

# 抽取姓氏和名字：
# 使用strsplit()函数以空格为界把学生姓名拆分为姓氏和名字
strsplit(new_roster$Student, " ") -> name
# 注意：strsplit()函数应用到一个字符串组成的向量上，返回的是一个列表
# 可使用sapply()函数提取列表中成分
sapply(name, '[', 1) -> Firstname # 提取列表中每个成分的第一个元素，放入储存名字的向量Firstname
sapply(name, '[', 2) -> Lastname # 提取列表中每个成分的第二个元素，放入储存姓氏的向量Lastname
# '[' 是一个可以提取某个对象的一部分的函数，这里用来提取列表name各成分中的第一或第二个元素
cbind(Firstname, Lastname, new_roster[, -1]) -> roster # 删掉不再需要的Student变量(在下标前加-剔除该列)

# 根据姓氏和名字排序：
roster[order(Lastname, Firstname), ] -> roster


# 控制流
# 正常情况下，R程序的语句是从上至下顺序执行的
# 有时，我们希望重复执行某些语句，仅在满足特定条件的情况下执行另外的语句
# 这就是控制流结构发挥作用的地方
# R有一般现代编程语言中都有的标准控制结构
# 首先将看到用于条件执行的语句，接下来是用于循环执行的结构

# 掌握以下概念：
# 语句statement是一条单独的R语句或一组复合语句(包含在花括号 {} 中的一组R语句，使用分号分隔)；
# 条件condition是一条最终被解析为真TRUE或假FALSE的表达式；
# 表达式expr是一条数值或字符串的求值语句；
# 序列seq是一个数值或字符串序列。

# 重复和循环：循环结构重复地执行一个或一系列语句，知道某个条件不为真为止
# 循环结构包括for循环和while循环

# for循环：重复地执行一个语句，直到某个变量的值不再包含在序列seq中为止
# 语法为 for (var in seq) statement
for (i in 1:10) print('hello') # 输出10次
for (i in 10) print('hello') # 输出1次

# while循环：重复地执行一个语句，直到条件不为真为止
# 语法为 while (cond) statement
10 -> i
while (i > 0) {print('hello'); i - 1 -> i} # 输出10次
# 注意：要确保while的条件语句能顾改变，即让它在某个时刻不再为真，否则会造成死循环

# 注意：在处理大型数据集中的行和列时，R中的循环较费时低效
# 尽可能联用R中的内建数值/字符处理函数和apply族函数

# 条件执行：在条件执行结构中，一条或一组语句仅在满足一个指定条件时执行
# 条件执行结构包括 if-else、ifelse和switch

# if-else结构
# 控制结构if-else在某个给定条件为真时执行语句，也可同时在条件为假时执行另外的语句
# 语法为： 
# if (cond) statement
# if (cond) statement1 else statement2
if (is.character(grade)) as.factor(grade) -> grade
if (!is.factor(grade)) as.factor(grade) -> grade else print('Grade already is a factor')

# ifelse结构：是if-else结构比较紧凑的向量化版本
# 语法为 ifelse(cond, statement1, statement2) 
# 若cond为TRUE，执行第一个语句；若cond为FALSE，执行第二个语句
ifelse(score > 0.5, print('passed'), print('failed'))
ifelse(score > 0.5, 'passed', 'failed') -> outcome
# 在程序的行为是二元时，或者希望结构的输入和输出均为向量时，务必使用ifelse

# switch结构：根据一个表达式的值选择语句执行
# 语法为 switch(expr, ...)
# 其中的...表示与expr的各种可能输出值绑定的语句
c('sad', 'afraid') -> feelings
for (i in feelings)
  print(
    switch(i,
           happy = 'i am glad u r happy',
           afraid = 'there is nothing to fear',
           sad = 'cheer up',
           angry = 'calm down now')
  )

# 自编函数
# 事实上，R中许多函数都是由已有函数构成的
# 函数的结构大致如下：
function(arg1, arg2, ...) {
  statements
  return(objects)
} -> myfunction
# 注意：函数中的对象只在函数内部使用
# 返回对象的数据类型是任意的，从标量到列表皆可

# 自编的描述性统计量计算函数
# 假设要编写一个函数，用来计算数据对象的集中趋势和散布情况
# 此函数应当可以选择性地给出参数统计量(均值和标准差)和非参数统计量(中位数和绝对中位差)
# 结果应当以一个含名称列表的形式给出
# 另外，用户应当可选择是否自动输出结果
# 除非另外指定，否则此函数的默认行为应当是计算参数统计量并且不输出结果
mystats <- function(x, parametric=TRUE, print=FALSE) {
  if (parametric) {
    mean(x) -> center;
    sd(x) -> spread
  } 
  else {
    median(x) -> center;
    mad(x) -> spread
  }
  if (print & parametric) {
    cat('Mean=', center, '\n', 'SD=', spread, '\n')
  }
  else if (print & !parametric) {
    cat('Median=', center, '\n', 'MAD=', spread, '\n')
  }
  list(center=center, spread=spread) -> result
  return(result)
}
# 查看函数的实战情况：
# 生成服从正态分布大小为500的随机样本
set.seed(1234)
rnorm(500) -> x
mystats(x) -> y # y$center将包含均值(0.00184)，y$spread将包含标准差(1.03)，并且没有输出结果
y[['center']]
y[[1]]
y$center
mystats(x, print = TRUE) -> y # 自动输出结果
y$center
mystats(x, parametric = FALSE, print = TRUE) -> y 
# 自动输出结果，y$center将包含中位数(-0.0207)，y$spread将包含绝对中位差(1.001)

# 使用switch结构的自编函数
# 此函数可让用户选择输出当天日期的格式
# 在函数声明中为参数指定的值将作为默认值，在函数mydate()中，若未指定type，则long将作为默认的日期格式
mydate <- function(type='long') {
  switch(type,
         long = format(Sys.time(), '%A %B %d %Y'),
         short = format(Sys.time(), '%m-%d-%y'),
         cat(type, 'is not a recognized type\n')
         )
}
mydate('long')
mydate() # 未指定type，则long将作为默认的日期格式
mydate('short')
mydate('a')
# 注意：这里的函数cat()仅在输入的type不匹配'long'或'short'时执行
# 通常要使用一个表达式来捕获用户错误输入的参数值
# 有若干函数可用来为函数添加错误捕获和纠正功能
# 可以使用函数warning()来生成一条错误提示信息
# 可以使用函数message()来生成一条诊断信息
# 可以使用函数stop()停止当前表达式的执行并提示错误


# 估计i个个体的Social network size(C)
personal_social_network_size <- function(m, e, N) {
  apply(m, 1, sum) / apply(m, 1, sum) -> a
  a * N -> c
  return(c)
}
# 此时：
# m以i行(个体数)j列(人群数)构成的矩阵的形式输入数据，如
matrix(1:10, nrow = 2) -> m
# e以i行(个体数)j列(人群数)构成的矩阵的形式输入数据，如
matrix(10:19, nrow = 2) -> n
personal_social_network_size(m, n, 40) -> c # 返回i个个体的c值构成的向量
# 估计人群j的艾滋病相关高危人群的规模(Ej)
Ej <- function(M, C, N) {
  sum(M) / sum(c) * N -> e
  return(e)
}
# 此时，给定人群j：
# m[, j] -> M
# c通过上面第一个函数计算得到
Ej(m[, 2], c, 30)


# 数据的整合与重构
# R中提供了许多用来整合(aggregate)和重塑(reshape)数据的强大方法
# 在整合数据时，往往将多组观测值替换为根据这些观测计算的描述性统计量
# 在重塑数据时，则会通过修改数据的结构(行和列)来决定数据的组织方式

# 数据集mtcars：是从Motor Trend杂志(1974)提取的
# 描述了34种车型的设计和性能特点(汽缸数、排量、马力、每加仑汽油行驶的英里数等)
?mtcars

# 转置(反转行和列)：重塑数据集
# 使用函数t()即可对一个矩阵或数据框进行转置
# 对于后者，行名将变成变量(列)名
mtcars[1:5, 1:4] -> cars
t(cars)

# 整合数据
# 在R中使用一个或多个by变量和一个预先定义好的函数来折叠(collapse)数据
# 格式为 aggregate(x, by, FUN)
# 其中x是待折叠的数据对象，by是一个变量名组成的列表，这些变量将被去掉以形成新的观测
# FUN是用来计算描述性统计量的标量函数，可以是任意的内建或自编函数，将被用来计算新观测中的值
# 注意：在使用aggregate()函数时，by中的变量必须在一个列表中(即使只有一个变量)
# 下面根据汽缸数和挡位数整合mtcars数据，并返回各个数值型变量的均值
options(digits = 3)
attach(mtcars)
aggregate(mtcars, by=list(cyl, gear), FUN=mean, na.rm=TRUE) -> aggdata
# 在结果中，Group.1表示汽缸数量(4、6或8)，Group.2代表挡位数(3、4或5)
# 举例来说，拥有4个汽缸和3个挡位车型的每加仑汽油行驶英里数(mpg)的均值为21.5
# 我们可以在by列表中为各组声明自定义名称，如
aggregate(mtcars, by=list(Group.cyl=cyl, Group.gears=gear), FUN=mean, na.rm=TRUE) -> aggdata
aggdata[, c(-4, -12)] -> new_aggdata

# reshape2包：一套重构和整合数据集的万能工具
# 如，原始数据集：
"
ID Time X1 X2
1 1 5 6
1 2 3 5
2 1 6 1
2 2 2 4
" -> mydatatxt
read.table(header=TRUE, text=mydatatxt) -> mydata
# 我们需要首先将数据融合(melt)，以使每一行都是唯一的标识符-变量组合
# 然后将数据重铸(cast)为你想要的任何形状，在重铸过程中，可以使用任何函数对数据进行整合
# 在这个数据集中，测量measurement是指最后俩列中的值
# 每个测量都能被标识符变量(在本例中，标识符是指ID和Time，观测指X1或X2)唯一地确定
# 举例来说，知道ID为1，Time为1，以及属于变量X1后，即可确定测量值为第一行中的5

# 融合：
# 数据集的融合是将它重构为：每一行都是唯一的标识符-变量组合
# 每个测量变量独占一行，行中带有要唯一确定这个测量所需的标识符变量
melt(mydata, id=c('ID', 'Time')) -> md
md
# 注意：必须指定要唯一确定每个测量所需的变量(ID和Time)，而表示测量变量名的变量(X1或X2)将由程序自动创建

# 重铸：
# 使用dcast()函数将数据集重铸为任意形状
# dcast()读取已融合的数据，并使用用户提供的公式和一个(可选)用于整合数据的函数将其重塑
# 格式为 dcast(md, formula, fun.aggregate) -> newdata
# 其中，md为已融合的数据，formula描述了想要的最后结果，其接受的公式形如：
# rowvar1 + rowvar2 + ... ~ colvar1 + colvar2 + ...
# 在这一公式中，rowvar1 + rowvar2 + ...定义要划掉的变量集合，以确定各行的内容
# 而colvar1 + colvar2 + ...则定义要划掉的变量集合，以确定各列的内容
# fun.aggregate是(可选)数据整合函数
dcast(md, ID + Time ~ variable) 
dcast(md, ID + variable ~ Time)
dcast(md, ID ~ variable + Time)
# 注意：不包含函数，数据仅被重塑；指定数据整合函数，即同时对数据进行重塑与整合
dcast(md, ID ~ variable, mean) # 给出每个观测所有时刻中在X1和X2上的均值
dcast(md, Time ~ variable, mean) # 给出每个时刻所有观测在X1和X2上的均值，即：
# 给出X1和X2在时刻1和时刻2的均值，对不同的观测进行了平均
dcast(md, ID ~ Time, mean) # 给出每个观测X1和X2在时刻1和时刻2上的均值，即：
# 给出每个观测在时刻1和时刻2的均值，对不同的X1和X2进行了平均

# 注意：在分析重复测量数据(为每个观测记录了多个测量的数据)时，
# 通常需要将数据转化为类似于融合后的md数据集那样的长格式数据






