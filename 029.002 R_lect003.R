# lect003
# 陆震
# 2019/06/03

# 将数据表示为矩阵或数据框这样的矩形形式仅仅是数据准备的第一步
"
manager date country gender age q1 q2 q3 q4 q5
1 10/24/08 US M 32 5 4 5 5 5 
2 10/28/08 US F 45 3 5 2 5 5
3 10/01/08 UK F 25 3 5 5 5 2
4 10/12/08 UK M 39 3 3 4 NA NA 
5 05/01/09 UK F 99 2 2 1 2 1
" -> leadershiptxt
read.table(header=TRUE, text=leadershiptxt, stringsAsFactors = FALSE) -> leadership
# 或：
# c(1, 2, 3, 4, 5) -> manager
# c('10/24/08', '10/28/08', '10/01/08', '10/12/08', '05/01/09') -> date
# c('US', 'US', 'UK', 'UK', 'UK') -> country
# c('M', 'F', 'F', 'M', 'F') -> gender
# c(32, 45, 25, 39, 99) -> age
# c(5, 3, 3, 3, 2) -> q1
# c(4, 5, 5, 3, 2) -> q2
# c(5, 2, 5, 4, 1) -> q3
# c(5, 5, 5, NA, 2) -> q4
# c(5, 5, 2, NA, 1) -> q5
# data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors=FALSE) -> leadership

# 运算符
# / 除
# ** 求幂
# x %% y 求余(x mod y)，如5 %% 2的结果为1
# x %/% y 整数除法，如5 %/% 2的结果为2

# 创建新变量：
# 将两个新变量整合到原始的数据框中，有四种方式：
data.frame(x1=c(2, 2, 6, 4),
           x2=c(3, 4, 2, 8)) -> mydata
# 1)
mydata$x1 + mydata$x2 -> mydata$sumx
(mydata$x1 + mydata$x2)/2 -> mydata$meanx
# 2)
attach(mydata)
x1 + x2 -> mydata$sumx
(x1 + x2)/2 -> mydata$meanx
detach(mydata)
# 3)
with(mydata, {
  x1 + x2 ->> mydata$sumx
  (x1 + x2)/2 ->> mydata$meanx
  str(mydata)
})
str(mydata)
# 4)
transform(mydata,
          sumx = x1 + x2,
          meanx = (x1 + x2)/2) -> mydata 
# transform()函数简化了按需创建新变量并将其保存到数据框中的过程

# 变量的重编码：重编码涉及根据同一个变量和/或其他变量的现有值创建新值的过程
# 如：
# 将一个连续型变量修改为一组类别值；
# 将误编码的值替换为正确值；
# 基于一组分数线创建一个表示及格/不及格的变量。
# 要重编码数据，可使用R中的逻辑运算符，逻辑运算符表达式可返回TRUE或FALSE

# 逻辑运算符：
# <= 小于等于
# >= 大于等于
# == 严格等于，类似于其他科学计算语言，R中比较浮点型数值时慎用 == ，以防出现误判
# != 不等于
# !x 非x
# x | y x或y
# x & y x和y
# isTRUE(x) 测试x是否为TRUE

"
manager date country gender age q1 q2 q3 q4 q5
1 10/24/08 US M 32 5 4 5 5 5 
2 10/28/08 US F 45 3 5 2 5 5
3 10/01/08 UK F 25 3 5 5 5 2
4 10/12/08 UK M 39 3 3 4 NA NA 
5 05/01/09 UK F 99 2 2 1 2 1
" -> leadershiptxt
read.table(header=TRUE, text=leadershiptxt, stringsAsFactors = FALSE) -> leadership
NA -> leadership$age[leadership$age == 99] # 将99岁的年龄值重编码为缺失值
# 语句 expression -> variable[condition] 仅在condition的值为TRUE时执行赋值
# 将连续型年龄变量age重编码为类别型变量agecat(Young、Middle Aged、Elder)
'Elder' -> leadership$agecat[leadership$age > 75] # 确保新变量能够保存到数据框中
'Middle Aged' -> leadership$agecat[leadership$age >= 55 &
                                     leadership$age <= 75]
'Young' -> leadership$agecat[leadership$age < 55]
# 也可以写成：
within(leadership, {
  NA -> agecat
  'Elder' -> agecat[age > 75]
  'Middle Aged' -> agecat[age >= 55 & age <= 75]
  'Young' -> agecat[age < 55]
  factor(agecat, ordered = TRUE, levels = c('Young', 'Middle Aged', 'Elder')) -> agecat
}) -> leadership
# 函数within()与函数with()类似，不同的是它允许你修改数据框
# 首先，创建agecat变量，并将每一行都设为缺失值
# 括号中剩下的语句接下来将依次执行
# 需要注意，最初的agecat只是一个字符型变量，可能要把它转换成有序型因子

# 若干程序包都提供了实用的变量重编码函数
# car包中的recode()函数可以十分简便地重编码数值型、字符型向量或因子
# doBy包提供函数recodevar()
# R自带cut()，可将一个数值型变量按值域切割为多个区间，并返回一个因子

# 变量的重命名：
# 交互式修改
fix(leadership)
# 编程式修改
names(leadership)
'manager' -> names(leadership)[1]
names(leadership)
c('item1', 'item2', 'item3', 'item4', 'item5') -> names(leadership)[6:10]
names(leadership)
# plyr包(有一系列强大的数据集操作函数)的函数rename()也可用于修改变量名
rename(leadership, c(manager='new_manager', testDate='new_testDate')) -> leadership

# 缺失值
# R中缺失值以NA(Not Available)表示，与SAS等程序不同，R中字符型和数值型数据使用的缺失值符号相同
c(1, 2, 3, NA) -> y
is.na(y) # 识别是否存在缺失值，返回一个相同大小的对象
is.na(leadership[, 6:10])
# 在处理缺失值的时候，需要注意：
# 1. 缺失值是不可比较的，即便是与缺失值自身的比较，这意味着无法使用比较运算符来检测缺失值是否存在
# 如，逻辑测试 myvar == NA 的结果永远不会为TRUE，我们只能使用处理缺失值的函数来识别出R数据对象的缺失值
# 2. R不会把无限的或不可能出现的数值标记为缺失值。
# 正无穷和负无穷分别用Inf和-Inf标记，因而 5/0 返回Inf；
# 不可能的值(如 sin(Inf))用NaN(not a number，不是一个数)标记；
# 要识别这些数值，需要用到is.infinite()或is.nan()

# 确定了缺失值的位置后，需要进一步在数据分析前以某种方式删除缺失值
# 含有缺失值的算术表达式和函数的计算结果也是缺失值
c(1, 2, NA, 3) -> x
x[1] + x[2] + x[3] + x[4] -> y
sum(x) -> z
# y和z都是NA
# 多数的数值函数都有一个 na.rm=TRUE 选项，可在计算前移除缺失值并使用剩余值进行计算
sum(x, na.rm = TRUE) -> t
# 在使用函数处理不完整的数据时，务必查看函数的帮助文档，检查这些函数是如何处理缺失数据的
# 可以通过函数na.omit()移除所有含有缺失值的观测，即删除所有含有缺失数据的行
na.omit(leadership) -> newdata
# 删除所有含有缺失数据的观测(称为行删除listwise deletion)是处理不完整数据集的方法之一
# 若只有少数缺失值或缺失值仅集中于一小部分观测中，行删除不失为处理缺失值的好方法
# 但若缺失值遍布于数据之中，或者一小部分变量中包含大量的缺失数据，行删除可能会删除相当比例的数据

# 日期值
# 通常以字符串的形式输入到R中，然后转化为以数值形式存储的日期变量，函数as.Data()实现该操作
# 日期值的默认输入格式为 yyyy-mm-dd
as.Date(c('2019-06-04', '2019-06-05')) -> nowadays # 将默认格式的字符型数据转换为了对应日期
# as.Date(x, 'input_format')，其中x为字符型数据，input_format给出用于读取日期的适当格式

# 日期格式：
# %d 数字表示的日期(0~31)
# %a 缩写的星期名
# %A 非缩写星期名
# %m 月份(00~12)
# %b 缩写的月份
# %B 非缩写月份
# %y 两位数的年份
# %Y 四位数的年份

c('01/05/1965', '08/16/1975') -> strDates
as.Date(strDates, '%m/%d/%Y') -> dates # 使用mm/dd/yyyy的格式读取数据，转化为日期值
'%m/%d/%y' -> myformat
as.Date(leadership$date, myformat) -> leadership$date 
# 使用指定格式读取字符型变量，并将其作为一个日期变量替换到数据框中
leadership$date

# 有两个函数对处理时间戳数据特别实用
Sys.Date() -> today # 返回当天日期
date() -> now # 返回当前日期和时间
format(today, format='%B/%d/%Y') -> new_today # 输出指定格式的日期值
format(today, format='%B   %d   %Y')
format(today, '%Y') -> year # 提取日期值中的某些部分

# R的内部在存储日期时，是使用自1970年1月1日以来的天数表示的，更早的日期表示为负数
# 这意味着可以在日期值上进行算术运算
as.Date('1995-08-01') -> birth
as.Date('2019-06-04') -> now
now - birth -> days
days
# 可使用函数difftime()计算时间间隔，可以星期、天、时、分、秒来表示
as.Date('1997-08-20') -> baby_birth
Sys.Date() -> today
difftime(today, baby_birth, units = 'weeks') -> days
days

# 将日期转换为字符型变量：函数as.character()可将日期值转换为字符型
as.character(dates) -> strDates
# 进行转换后，即可使用一系列字符处理函数处理数据(如取子集、替换、连接等)

# 了解字符型数据转换为日期，查看 ?strftime
# 了解更多关于日期和时间格式，查看 ?ISOdatetime
# lubridate包中包含了许多简化日期处理的函数，可用于识别和解析日期-时间数据，抽取日期-时间成分，
# 以及对日期-时间值进行算术运算。
# 如果需要对日期进行复杂的计算，可查看timeDate包，
# 它提供了大量的日期处理函数，可同时处理多个时区，并且提供了复杂的历法操作功能，支持工作日、周末以及假期。

# 类型转换：
# 上面讨论了将字符型数据转换为日期值以及逆向转换的方法
# R中提供了一系列用来判断对象数据类型和将其转换为另一种数据类型的函数
# R与其他统计编程语言有着类似的数据类型转换方式
# 如，向一个数值型向量中添加一个字符串会将此向量中的所有元素转换为字符型
c(1, 2, 3, 'luzhen') -> a
str(a)

# 类型转换函数
# is.numeric() as.numeric()
# is.character() as.character()
# is.vector() as.vector()
# is.matrix() as.matrix()
# is.data.frame() as.data.frame()
# is.factor() as.factor()
# is.logical() as.logical()
# is.datatype()这样的函数可以允许根据数据的具体类型以不同的方式处理数据
# as.datatype()这类函数可以允许在数据分析前将数据转换为要求的格式

# 数据排序
# 可以使用order()函数对一个数据框进行排序，默认排序顺序为升序
leadership[order(leadership$age), ] -> newdata # 创建一个新数据集，其中各行依经理人的年龄升序排序
with(leadership,
     leadership[order(gender, age), ] ->> newdata) # 将各行依女性到男性、同样性别中按年龄升序排序
# 在排序变量的前边加一个减号即可得到降序的排序结果
with(leadership,
     leadership[order(gender, -age), ] ->> newdata) # 将各行依女性到男性、同样性别中按年龄降序排序
with(leadership,
     leadership[order(gender, age), ] -> newdata) # 会报错

# 数据集的合并
# 如果数据分散在多个地方，在继续分析之前需要将其合并

# 向数据框中添加列(变量)：
# 要横向合并两个数据框，使用merge()函数
# 多数情况下，两个数据框通过一个或多个共有变量进行联结的(即一种内联结inner join)
# merge(dataframeA, dataframeB, by='ID') -> total 将俩个数据框按照ID进行合并
# merge(dataframeA, dataframeB, by=c('ID', 'Country')) -> total 将俩个数据框按照ID和Country进行合并
# 类似的横向联结通常用于向数据框中添加变量
# 若直接横向合并俩个矩阵或数据框，且不需要指定一个公共索引，可以直接食用cbind()函数
# cbind(A, B) -> total 横向合并对象A和对象B，要求每个对象必须行数相同，以同顺序排序

# 向数据框中添加行(观测)：
# 要纵向合并两个数据框，使用rbind()函数，要求俩个数据框必须有相同的变量，不过变量的顺序不必一定相同
# rbind(dataframeA, dataframeB) -> total
# 若dataframeA中有dataframeB没有的变量，在合并前需要做以下某种处理：
# 1. 在dataframeB中创建追加的变量，并将其值设为NA
# 2. 删除dataframeA中的多余变量
# 纵向联结通常用于向数据框中添加观测

# 数据集取子集
# R有强大的索引特性，可用于访问对象中的元素
# 可以利用这些特效对变量或观测进行选入和排除

# 选入(保留)变量
# 从一个大数据集中选择有限数量的变量来创建一个新的数据集是常有的事
# 数据集中的元素可通过 dataframe[row_indices, column_indices] 这样的记号来访问，也可沿用这种方法选择变量
leadership[, c(6:10)] -> newdata # 将行下标留空表示默认选择所有行
# 等价于
leadership[c(6:10)] -> newdata
# 或
c('q1', 'q2', 'q3', 'q4', 'q5') -> myvars
leadership[myvars] -> newdata
# 可实现等价的变量选择，这里，变量名充当了列的下标，因而选择的列是相同的
# 或
paste('q', 1:5, sep = '') -> myvars
leadership[myvars] -> newdata
# 使用paste()函数创建了与上面相同的字符型向量

# 剔除(丢弃)变量
# 剔除变量q3和q4
names(leadership) %in% c('q3', 'q4') -> myvars
myvars
leadership[!myvars] -> newdata
# names(leadership)生成一个包含所有变量名的字符型向量
# names(leadership) %in% c('q3', 'q4')返回一个逻辑型向量，names(leadership)中每个匹配q3或q4的元素的值为TRUE
# 运算符 非! 将逻辑值反转
# leadership[!myvars]选择逻辑值为TRUE的列，于是q3和q4被剔除了
# 在知道q3和q4是第8个和第9个变量的情况下，也可以采用：
leadership[c(-8, -9)] -> newdata # 在某一列的下标之前加一个减号-就会剔除那一列
# 等价于
leadership[, c(-8, -9)] -> newdata
# 相同的变量删除工作也可以采用：
NULL -> leadership$q3 -> leadership$q4 # 这里将q3和q4俩列设为了未定义NULL
# 注意：NULL与NA(表示缺失)是不同的

# 例子：
read.csv('tumor_data.csv') -> tumor
tumor$genenames %in% c("RPL13AP5", "RPL21", "RPS17", "RPL21P28", "RPS10", "IGF2", "H3F3AP4", "RPL13A",
                       "BMP4", "EIF4A1", "SLC25A6", "GNB2L1", "EEF1G", "RPSA", "RPLP0", "FOS", "RPS6",
                       "RPL7A", "RPS8", "RPL8", "H19", "UBD", "LANCL2", "GDF15", "HIST1H4C", "PHLDA2",
                       "UBE2C", "CCND2", "CXCL3", "HNRNPL", "CXCL2", "PDCD5", "ROMO1", "HMGB1",
                       "C8orf33", "SNHG5", "EIF2S2", "TMSB4X", "PFDN4", "VOPP1", "ZG16", "SPINK1",
                       "HSPA1A", "PIGR", "MALAT1", "FCGBP", "PI3", "TFF3", "CCL20", "LCN2", "SLC26A2",
                       "RPL13", "FN1", "MUC2", "C2orf82", "UQCR11", "CES2", "C15orf48", "HLA-A", 
                       "NDUFA1", "LCN15", "UGDH-AS1", "ANXA1", "APOBEC3C", "ARL14", "CKB", "RAB3B",
                       "FABP1", "SOX4", "PRAC1", "RPS4Y1", "TM4SF1", "MALAT1", "DSG3", "ACOT13",
                       "PHLDA1", "UQCRQ", "SHISA9", "RNF149", "HES1", "KLK6", "TFF1", "ANPEP",
                       "MUC1", "MIF", "NME2", "RNASE1", "ASS1", "TST", "TSPAN1", "IGFL2", "PPIB",
                       "S100A14", "LYZ", "GAPDH", "PPP1R1B", "C10orf99", "GPA33", "KLK10", "LCN2",
                       "KRT23", "SMARCE1", "MIEN1", "KRT10", "IGFBP4", "KRT20", "ERBB2", "LGALS1", 
                       "STARD3", "CD55", "POMP", "AGR3", "CRIP1", "MTIF3", "SFTA2", "TNS4", "RPS4Y1",
                       "TMEM99", "PRSS3", "SEC62", "MMP7", "UBD", "IGLL5", "S100A9", "IGJ", "HULC",
                       "CD74", "HLA-DRA", "FTH1", "UCA1", "IFI6", "BIRC3", "IL32", "MZB1", "PSMB9",
                       "SOD2", "SRGN", "TGM2", "TCEB2", "PRSS23", "DEFA6", "WFDC2", "ANXA13", "ATOH1",
                       "GUCA2A", "HSPA6", "BTG2", "PCSK1", "HEPACAM2", "REG4", "TUBA1A", "DNAJB1", 
                       "LOC101929549", "HES6", "H3F3AP4", "DYRK4", "DBNDD2", "BLCAP", 
                       "KLK12", "COLCA2") -> genes
tumor[genes, ] -> genes_data

# 丢弃变量是保留变量的逆向操作，选择哪一种方式进行变量筛选取决于两种方式的编码难易程度
# 如果有许多变量需要丢弃，那么直接保留需要留下的变量即可，反之亦然

# 选入观测：选入或剔除观测(行)通常是成功的数据准备和数据分析的一个关键方面
leadership[1:3, ] -> newdata # 只提供了行下标，并将列下标留空，选择前三个观测所有变量
leadership[1:3] -> newdata # 注意：这里选的是前三列
leadership[leadership$gender == 'M' & leadership$age > 30, ] -> newdata # 选取30岁以上男性
# 或
with(leadership, 
     leadership[gender == 'M' & age > 30, ] ->> newdata) # 此时不必在变量名前加上数据框名称
# 或
attach(leadership)
leadership[gender == 'M' & age > 30, ] -> newdata # 此时不必在变量名前加上数据框名称
detach(leadership)
# 将研究范围限定在2008年1月1日到2008年12月31日
as.Date(leadership$date, '%m/%d/%y') -> leadership$date # 读入字符串日期
as.Date('2008-01-01') -> startdate # 以默认格式创建开始日期
as.Date('2008-12-31') -> enddate # 以默认格式创建结束日期
leadership[which(leadership$date >= startdate & leadership$date <= enddate), ] -> newdata
# 等价于
leadership[leadership$date >= startdate & leadership$date <= enddate, ] -> newdata

# subset()函数：使用此函数大概是选择变量和观测最为简单的办法
subset(leadership, age >= 35 | age < 24,
       select = c(q1, q2, q3, q4)) -> newdata # 选择age>=35或age<=24的所有观测的q1、q2、q3和q4列
subset(leadership, gender == 'M' & age > 25,
       select = gender:q4) -> newdata # 选择25岁以上男性的从gender到q4的所有列，包含gender和q4列
# 注意：冒号运算符 from:to ，表示变量from到变量to所包含的所有变量(包含变量from和变量to)

# 随机抽样
# 在数据挖掘和机器学习领域中，从更大的数据集中抽样是很常见的做法
# sample()函数可以实现从数据集中(有放回或无放回地)抽取大小为n的一个随机样本
leadership[sample(1:nrow(leadership), 3, replace = FALSE), ] -> mysample
# sample()函数的第一个参数是一个由要从中抽样的元素组成的向量
# 第二个参数是要抽取的元素数量，第三个参数表示无放回抽样
# 最后返回随机抽样得到的元素，之后即可用于选择数据框中的行
# R中有齐全的抽样工具，包括抽取和校正调查样本(参见sampling包)以及分析复杂调查数据(参见survey包)工具

# 使用SQL语句操作数据框
# 数据分析人员需要精通结构化查询语言(SQL)
# sqldf包是R中一个实用的数据管理辅助工具
# 可以使用sqldf()函数在数据框上使用SQL中的SELECT语句
# 从数据框mtcars中选择所有的变量(列)，保留那些使用化油器(carb)的车型(行)
# 按照mpg对车型进行升序排序，参数row.names=TRUE将原始数据框中的行名称延续到新数据框中
sqldf('select * from mtcars where carb=1 order by mpg',
      row.names=TRUE) -> newdf
# 输出四缸和六缸车型每一gear水平的mpg和disp的平均值
sqldf('select avg(mpg) as avg_mpg,
      avg(disp) as avg_disp, gear from mtcars where cyl in (4, 6) group by gear')

# 调试：
# 调试是寻找和减少程序中错误或缺陷的过程
# R处理错误和警告的方法过于简洁
# 如：
# 给mtcars数据集中的变量am详细的标题和标签
factor(mtcars$a, levels = c(1, 2), labels = c('Automatic', 'Manual')) -> mtcars$Transmission
# 等价于
factor(mtcars$am, levels = c(1, 2), labels = c('Automatic', 'Manual')) -> mtcars$Transmission
aov(mpg ~ Transmission, data = mtcars) # 报错
head(mtcars[c('mpg', 'Transmission')]) # 查看传递给aov()函数的数据
table(mtcars$Transmission) # 发现变量am被编码为1=Automatic，且有缺失，而不是我们想要的1=Automatic，2=Manual
table(mtcars$am) # 发现变量am没有2，只有1和0
# 而factor()函数仍然执行下去了，它将所有的1转化为Automatic，将0设为缺失，没有任何提醒或错误信息
# 因而方差分析失败报错
# 要学会检查确认每个输入函数是否包含我们预期的数据

# 调试工具：
# 尽管检查对象名、函数参数和函数输入可以找到很多错误来源，但有时还必须深入研究函数内部运作机制和调用函数的函数
# 此时，R自带的内部调试器发挥作用

# 内部调试函数：
debug() # 选择一个函数进行调试
undebug() # 关闭调试功能
browser() # 允许单步每次调试一行函数，调试时，输入n或按回车键执行当前语句并移动到下一行语句
# 输入c跳出单步运行模式并执行当前函数剩余的部分
# 输入where显示调用的堆栈，输入Q退出browser()模式并立即跳到顶层
# 其他的R命令诸如ls()、print()和赋值语句可以在调试器中使用
trace() # 临时在函数中插入调试代码
untrace() # 取消追踪并删除临时代码
traceback() # 一个函数调用其他函数，它很难确定错误发生在哪，可用此函数列出导致错误的调用函数序列，最后一个调用即错误原因

# 如：
# mad()函数计算一个数值向量的中位数绝对偏差
# 这里使用debug()函数来探索该函数的工作原理
mad
args(mad) # 查看形式参数，即参数名称和mad()函数的默认值
debug(mad) # 开始debug，此后，只要mad()函数被调用，browser()函数都会被执行，会话进入browser()模式，允许一次执行一行函数
mad(1:10) # 函数的代码会被列出，但不执行，且，提示 > 更改为 Browse[n]> ，其中n表示浏览层级，数值随每次递归调用递增
# 在browser()模式中，可以使用其他函数，也可以通过键入赋值语句改变对象的值:
ls() # 列出在mad()函数执行过程中，在给定点存在的对象
center # 输入一个对象的名字将展示它的内容
constant
na.rm
x
# 这里要注意：若一个对象是以n、c或Q命名的，必须使用print(n)、print(c)或print(Q)来查看它的内容:
n # 单步运行代码，也可按回车键
n
n
print(n)
where # where语句显示正在执行的函数调用在堆栈的何处，在有函数可调用其他函数时，它会很有用
c # 跳出单步运行模式并执行当前函数剩余的部分
Q # 退出browser()模式并回到R提示 >
undebug(mad) # 关闭调试功能，注意：调试完成必须有这一步，否则后续调用该函数会进入调试模式

# 当运行循环且我们想看看值是如何改变时，使用debug()函数非常有用
# 我们可以直接在代码中嵌入browser()函数来帮助定位
# 如，假设我们有一个变量x，它的值永远不为负
if (x < 0) browser() # 这行代码可以让我们在出现问题时探索当前的状态
# 当函数调试完成时，要删掉无用的代码

# 通过设置选项在会话中直接进行调试：
# 若我们有调用函数的函数，有两个会话选项可以使用：
# R的默认状态下，当R遇到错误信息时，它会打印错误信息并退出函数
# 设置options(error = traceback)之后，一旦错误发生就会打印调用的栈(函数调用导致出错的序列)，能帮助查看产生错误的函数
# 设置options(error = recover)也会在出现错误时打印调用的栈
# 此外还会提示选择列表中的一个函数，并在选择某个函数后在相应环境中调用browser()函数
# 输入c会返回列表，输入0则退出到R提示
# 使用recover()模式可从函数调用的序列中选择查看任何函数的任意对象
# 通过有选择地查看对象的内容，我们可以频繁地查看且确定问题的来源
# 要返回至R的默认状态，可设置options(error = NULL)

# 如，使用recover()函数进行调试会话
f <- function(x, y) {
  x + y -> z
  g(z)
}

g <- function(x) {
  round(x) -> z
  h(z)
}

h <- function(x) {
  set.seed(1234)
  rnorm(x) -> z
  print(z)
}
# 函数f()调用函数g()，函数g()调用函数h()

options(error = traceback) 
f(2, -3) # 打印调用的栈(函数调用导致出错的序列)，能帮助查看产生错误的函数
options(error = NULL) 
f(2, -3) # 返回至R的默认状态，打印错误信息并退出函数
options(error = recover) 
f(2, -3) # 打印调用的栈，此外还会提示选择列表中的一个函数，并在选择某个函数后在相应环境中调用browser()函数

f(2, 3) # 运行良好无报错
f(2, -3) # 报错，且由于设置了options(error = recover)，会话立即转移到recover()模式
# 此时，函数调用的栈被打印出来，且可以选择列表中的一个函数，并在选择某个函数后在相应环境中调用browser()函数
# 此时，我们可以在browser()模式下检验所选择的函数
4 # 转移到rnorm()函数，并对其进行检验
ls() # 列出函数rnorm()中的所有对象
mean # 返回值为 0
sd # 返回值为 1
print(n) # 返回值为 -1
?rnorm
# 我们看到n=-1，而这在rnorm()函数中是不被允许的，所以这就是问题的所在
# 接下来要查看n为什么会变成-1，这就需要我们移动栈
# 输入c会返回列表菜单，选择接下来要检验的函数
3 # 转移到h()函数，并对其进行检验
ls()
x # 返回值为 -1
c
2 # 转移到g()函数，并对其进行检验
ls()
x # 返回值为 -1
z # 返回值为 -1
c
1 # 转移到f()函数，并对其进行检验
ls()
z
x
y
# 此时，我们已经清楚问题的所在以及其是如何一步步产生的：因为x=2，y=-3，所以z=-1
# 查看函数f()的代码(正常情况下键入函数名即可查看函数代码)：
print(f) # 注意：f是browser模式下的一个保留字，表明'完成当前循环或函数的执行'，我们用print()明确地避开这种特殊的意义
c # 返回列表菜单
0 # 退出到R提示
# 此时等价于
Q # 退出browser()模式并回到R提示 >


