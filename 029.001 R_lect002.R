# lect002
# 陆震
# 2019/06/01

# 数据框：与数据集类似，行为观测，列为变量
# 不同的列可以包含不同类型的数据，其概念较矩阵更为一般
# 数据框是R中最常处理的数据结构
# 使用函数data.frame()创建
c(1, 2, 3, 4) -> patientID
c(25, 34, 28, 52) -> age
c('Type1', 'Type2', 'Type1', 'Type1') -> diabetes
c('Poor', 'Improved', 'Excellent', 'Poor') -> status
data.frame(patientID, age, diabetes, status) -> patientdata
str(patientdata) # 函数str()显示R中某对象的信息(如数据结构)
summary(patientdata) # 显示对象的统计概要，会区别对待各个变量
# 索引：
patientdata[1:2] # 选取数据框的前俩列
patientdata[c('diabetes', 'status')] -> a # 选取数据框指定名称的列(变量)
patientdata$age # 选取数据框某个指定名称的列(变量)
table(patientdata$diabetes, patientdata$status) # 生成俩变量的列联表
patientdata[1, ] # 第一行
patientdata[1, 2] # 第一行第二列 
# 函数attach()将数据框添加到R的搜索路径中，R在遇到一个变量名后，将检查搜索路径中的数据框
attach(patientdata)
table(diabetes, status)
detach(patientdata) # 函数detach()将数据框从搜索路径中移除，不会影响数据框本身
# 注意：函数attach()和detach()最好在分析一个单独的数据框，并且不太可能有多个同名对象时使用
# 任何情况下，都要当心那些告知某个对象已被屏蔽masked的警告，这种情况下，原有对象将取得优先权
with(patientdata, {
  print(patientdata)
  table(diabetes, status)
}) # 花括号{}之间的语句都针对该数据框执行，无需担心名称冲突；若仅有一条语句，花括号可以省略
# 注意：函数with()内的赋值仅在此函数的括号内有效
with(patientdata, {
  patientdata -> a
  print(a)
})
print(a)
# 若要创建在with()结构外依然存在的对象，使用特殊赋值符号 ->> ，即可保存对象到全局环境中
with(patientdata, {
  patientdata ->> a
  print(a)
})

# 行/实例标识符case identifier：
# 在病例数据中，病人编号patientID用于区分数据集中不同的个体
# R中实例标识符可通过data.frame()中的rowname选项指定
data.frame(patientID, age, diabetes, status, 
           row.names = patientID) -> patientdata
print(patientdata)
# 将patientID指定为R中标记各类打印输出和图形中实例名称所用的变量

# 因子factor：
# 变量可分为名义型(无序分类变量)、有序类别型(表示顺序而非数量关系)和连续型变量
# 连续型变量可以呈现某个范围内的任意值，并同时表示顺序和数量，年龄是一个连续型变量
# 名义型变量和有序类别型变量称为因子
# 函数factor()以一个整数向量的形式存储类别值，同时一个由字符串(原始值)组成的内部向量将映射到这些整数上
c('Type1', 'Type2', 'Type1', 'Type1') -> diabetes
factor(diabetes) -> diabetes 
diabetes
# 将此向量存储为(1, 2, 1, 1)，并在其内部将其关联为1=Type1和2=Type2(具体赋值根据字母顺序决定)
# 针对向量diabetes进行的任何分析都会将其视为名义型变量
c('Poor', 'Improved', 'Excellent', 'Poor') -> status
factor(status, ordered = TRUE) -> status # 表示有序型变量，指定参数ordered=TRUE
# 此时顺序为'Excellent''Improved''Poor'，恰好与逻辑顺序一致
# 将此向量存储为(3, 2, 1, 3)，并在其内部将其关联为1=Excellent、2=Improved以及3=Poor
# 针对此向量进行的任何分析都会将其视为有序型变量

# 注意：对于字符型向量，因子的水平默认依字母顺序创建
# 可以通过指定levels选项覆盖默认排序
c('Poor', 'Improved', 'Excellent', 'Poor') -> status
factor(status, ordered = TRUE,
       levels = c('Poor', 'Improved', 'Excellent')) -> status 
# 此时顺序改为'Poor''Improved''Excellent'，在其内部将其关联为1=Poor、2=Improved以及3=Excellent
# 注意：需要保证指定的水平与数据中的真实值相匹配，任何在数据中出现而未在参数中列举的数据将被设为缺失值
c('Type1', 'Type2', 'Type1', 'Type1') -> diabetes
factor(diabetes, levels = c('Type2', 'Type1')) -> diabetes

# 数值型变量可用levels和labels参数将其编码为因子
# 若男性被编码为1，女性为2
# factor(patientdata$sex, levels = c(1, 2), labels = c('Male', 'Female')) -> patientdata$sex 
# 把变量sex转换成无序因子，levels代表变量的实际值，labels表示包含了理想值标签的字符型向量
# 此时，sex将被当作类别型变量，'Male'和'Female'将代替1和2在结果中输出，非1或2的性别将被设为缺失值

# 列表list：一些对象(成分component)的有序集合
# 允许整合若干对象到单个对象名下，其中的对象可以是目前为止学习到的任何结构
# 如某个列表中可以是若干向量、矩阵、数据框甚至其他列表的组合
# 使用函数list()创建列表
'My first list' -> g # 字符串
c(11, 14, 16, 18) -> h # 数值型向量
matrix(1:10, nrow = 5) -> j # 矩阵
c('one', 'two', 'three') -> k # 字符型向量
list(title=g, ages=h, j, k) -> mylist # 为列表中的对象命名
mylist
# 索引：
mylist[2] # 输出的是列表
mylist['ages'] # 输出的是列表
# 可通过在双重方括号中指明代表某个成分的数字或名称来访问列表中元素
mylist[[2]] # 输出的是向量
mylist[['ages']] # 输出的是向量
mylist$ages # 输出的是向量
# 许多R函数的运行结果都是以列表的形式返回的，需要取出其中哪些成分由分析人员决定

# 数据类型：包括数值型、字符型、逻辑型、复数型和原生型
# 有两种最基本的数据类型：原子向量atomic vector和泛型向量generic vector

# 原子向量：包含单个数据类型(逻辑型、实数、复数、字符串或原始类型)的数组
# 如，下面的每个都是一维原子向量：
c(TRUE, FALSE) -> c # 逻辑型
c(1, 2, 3, 4, -5) -> a # 实数型
c(1+2i, 0+1i, 39+3i, 12+2i) -> cmplxNums # 复数型
c('one', 'two') -> b # 字符串
# 注：'raw'类型的向量包含原始字节，这里不作讨论

# 许多R的数据类型是带有特定属性的原子向量
# 例如，R没有标量型数据，R中标量实际是具有单一元素的原子向量，2 -> k 是 c(2) -> k 的简写

# 矩阵是一个具有维度属性dim的原子向量，包含两个元素(行数和列数)
c(1, 2, 3, 4, 5, 6, 7, 8) -> a # 一维数字向量a
class(a) # class()函数读取和设置对象的类，这里返回值为"numeric"
attributes(a) # attributes()函数罗列对象属性
c(2, 4) -> attr(a, 'dim') # attr()函数设置对象属性，这里加上一个dim属性
class(a)
attributes(a) # 对象a现在变成了matrix类的2*4矩阵
a # 对象a现在变成了matrix类的2*4矩阵
# 矩阵的行名和列名也可以通过加上一个dimnames属性得到：
list(c('A1', 'A2'), c('B1', 'B2', 'B3', 'B4')) -> attr(a, 'dimnames')
class(a)
attributes(a)
str(a)
a
# 当然，矩阵也可以通过去除dim属性变成一维向量：
NULL -> attr(a, 'dim')
class(a)
attributes(a)

# 数组是一个具有维度属性dim的原子向量，包含三个或更多元素
# 同样，也可以使用dim属性来设置维度，还可以为标签赋予dimnames属性
# 与一维向量一样，矩阵和数据可以是逻辑型、实数、复数、字符串或原始类型，
# 但是，在一个矩阵或数组中不可混杂不同类型
c(1, TRUE, 'luzhen') -> a # a里元素全部转换为字符串
class(a)
attributes(a)
c(TRUE, 'luzhen') -> a # a里元素全部转换为字符串
c(1, TRUE) -> a # a里元素全部转换为实数型

# 注：attr()函数允许创建任意属性并将其与对象相关联，
# 属性存储关于对象的额外信息，函数能够用属性确定其处理方式
# 有很多特定的函数可用来设置属性，包括dim()、names()、dimnames()、row.names()、class()和tsp()
# 其中tsp()函数用来创建时间序列对象
# 这些特殊的函数对设置的取值范围有一定的限制，除非创建自定义属性，否则最好这些特殊函数
# 它们的限制和产生的错误信息使得编码时出现错误的可能性变少，且使错误更明显
1:12 -> x; c(3,4) -> dim(x)
class(x)
x

# 泛型向量或列表：列表是原子向量和/或其他列表的集合；数据框是集合中每个原子向量都有相同长度的特殊列表

# R中自带iris数据框，该数据框描述了150种植物的四种物理测度及其种类(setosa、versicolor或virginica)
head(iris)
# 该数据框实际上是包含五个原子向量的列表，每个向量代表数据框中的一列(变量)
unclass(iris) # 打印数据框并查看数据框
attributes(iris) # 查看数据集属性
# 它有一个names属性(变量名的字符串向量)，一个row.names属性(识别单个植物的数字向量)，
# 以及一个带有'data.frame'值的class属性

# 理解列表很重要，因为R的函数通常返回列表作为值
# 这里看一个使用聚类分析技巧的例子(聚类分析使用一系列方法识别观测值的天然分组)
# 这里使用K均值聚类分析对iris数据进行聚类分析：
# 假定数据中存在三类，观测这些观测值(行)是如何被分组的
# 此时忽略种类变量Species，仅使用每个植物的物理测度来聚类
set.seed(1234)
kmeans(iris[1:4], 3) -> fit
# 对象fit中都包含哪些信息呢？
fit
# kmeans()函数的帮助页面表明该函数返回一个包含七种成分的列表
?kemans
# str()函数展示对象的结构
str(fit)
# unclass()函数直接检查对象的内容
unclass(fit)
# length()函数展示对象包含多少成分
length(fit)
# names()函数提供这些成分的名字
names(fit)
# attributes()函数检查对象的属性
attributes(fit)
# 返回该对象中每个成分的类
sapply(fit, class)
# 返回值显示：
# cluster是包含所聚成的类的整数向量
# centers是包含聚类中心的矩阵(各个类中每个变量的均值)
# size是包含三类中每一类植物的整数向量
# 要了解其他成分，使用 ?kmeans 查看Value部分

# 学会理解列表中的信息是一个重要的R编程技巧
# 任何数据对象中的元素都可以通过索引来提取

# 提取原子向量中的元素
# 提取元素可使用 object[index] ，其中object是向量，index是一个整数向量
# 若原子变量中的元素已经被命名，index也可以是这些名字中的字符串向量
# 注意：R中索引从1开始，而非其他语言一样从0开始
c(1, 2, 3, 4, -5) -> a
a[c(2, 4)]
# 注意：a[2, 4] 报错
c(A=1, B=2, C=3) -> x # 原子变量中的元素已经被命名
x[c(2, 3)]
x[c('B', 'C')]
# 注意：x[c(B, C)] 报错

# 提取列表中的元素
# 可使用 object[index] 来提取成分(原子向量或其他列表)，其中index是一个整数向量
# 使用上面例子中kemans的fit对象说明
fit[c(2, 7)] # 需要注意的是，此时返回的是以列表形式出现的成分
fit[2, ] # 报错
fit[2, 7] # 报错
# 可使用 object[[index]] 得到成分中的元素
fit[2] # 输出的是列表
fit[[2]] # 输出的是矩阵
class(fit[[2]])
# 注意：这种区别是很重要的，如果想把得到的结果作为一个矩阵输入，应该使用双括号
# 可以组合符号以获得成分内的元素
fit[[2]][1, ] # 提取fit的第二个成分并返回其中第一行 
fit[[c(2, 7)]] # 注意：此时返回的是第二个成分的第7个元素
fit[[2, 7]] # 报错
# 若想获取单个的命名成分(注意：必须是命名成分)，可以使用符号 $
# 此时，object[[index]]和object$name等价
fit$centers 
# 这里解释为什么符号 $ 也可以在数据框中进行操作：
# 数据框是集合中每个原子向量都有相同长度的特殊列表，这里每个变量被看作一个成分
# 这就是为什么iris$Sepal.Length会返回150个元素向量

# 通过提取函数返回的成分和列表的元素，可以继续深入
# 如，可以画出聚类中心的线图：
set.seed(1234)
kmeans(iris[1:4], 3) -> fit
fit$centers -> means # 提取聚类中心的矩阵(行是类，列是变量的均值)
# 矩阵通过reshape2包被重塑成长格式
library(reshape2)
melt(means) -> dfm
# 等价于
melt(means, id=c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width')) -> dfm
class(dfm)
c('Cluster', 'Measurement', 'Centimeters') -> names(dfm)
class(dfm$Cluster)
attributes(dfm$Cluster)
str(dfm$Cluster)
factor(dfm$Cluster) -> dfm$Cluster
class(dfm$Cluster)
attributes(dfm$Cluster)
str(dfm$Cluster)
head(dfm)
str(dfm)
# 通过ggplot2包绘制线图
library(ggplot2)
ggplot(data = dfm,
       aes(x=Measurement, y= Centimeters, group=Cluster)) +
  geom_point(size=3, aes(shape=Cluster, color=Cluster)) +
  geom_line(size=1, aes(color=Cluster)) +
  ggtitle('Profiles for Iris Clusters')
# 注意：这里所有的变量作图要使用相同的测量单位(厘米)
# 若聚类分析涉及不同尺度的变量，需要在绘图前标准化数据，并标记y轴为标准化得分

# 注意：
# 1. 对象名称中的句点.没有特殊意义，但美元符号$的含义与其他语言中的句点含义类似，
# 即指定一个数据框或列表中的某些部分，如A$x是指A中的变量x
# 2. R不提供多行注释或块注释功能，必须以#作为多行注释每行的开始。
# 出于调试目的，可以把想让解释器忽略的代码放到语句if(FALSE){...}中，将FALSE改为TRUE即允许执行这块代码
# 3. 将一个值赋给某个变量、矩阵、数组或列表中一个不存在的元素时，
# R将自动扩展这个数据结构以容纳新值。
c(8, 6, 4) -> x
10 -> x[7]
x # 通过赋值，向量x由三个元素扩展到了七个元素，由缺失值NA填充
x[1:4] -> x # 将其缩减到四个元素
# 4. R中没有标量，标量以单元素向量的形式出现。
# 5. R中的下标从1开始。
# 6. 变量无法被声明，变量在首次被赋值时生成。

# 处理小数据集时可使用键盘输入数据：
# 有两种常见的方式：用R内置的文本编辑器和直接在代码中嵌入数据

# R中的函数edit()会自动调用一个允许手动输入数据的文本编辑器
# 步骤如下：
# 1. 创建一个空数据框(或矩阵)，其中变量名和变量的模式需与理想中的最终数据集一致
# 2. 针对这个数据对象调用文本编辑器，输入数据，并将结果保存回此数据对象中
data.frame(age=numeric(0),
           gender=character(0), weight=numeric(0)) -> mydata
# 类似于age=numeric(0)的赋值语句将创建一个指定模式但不含实际数据的变量
edit(mydata) -> mydata # 注意：编辑的结果需要赋值回对象本身
fix(mydata) # 简捷的等价写法
# 函数edit()事实上是在对象的一个副本上进行操作的，如果不将其赋值到一个目标，你的所有修改将会全部丢失！
# 单击列的标题，可以用编辑器修改变量名和变量类型(数值型、字符型)
# 可通过单击未使用列的标题来添加新的变量
# 编辑器关闭后，结果会保存到之前赋值的对象中

# 当然，也可以直接在程序中嵌入数据集
"
age gender weight
25 m 166
30 f 115
18 f 120
" -> mydatatxt # 创建一个字符型向量用于存储原始数据
read.table(header = TRUE, text = mydatatxt) -> mydata # read.table()处理字符串并返回数据框
# 以上代码创建了和之前使用edit()函数所创建的一样的数据框

# 导入Excel数据：xlsx包
# 函数read.xlsx()导入一个工作表到一个数据框中
# 如 'C:/myworkbook.xlsx' -> workbook 从位于C盘根目录的myworkbook.xlsx中导入第一个工作表
# read.xlsx(workbook, 1) -> mydataframe
# read.xlsx()有些选项允许指定工作表中特定的行(rowIndex)和列(colIndex)，配合上对应每一列的类(colClasses)
# 对于大型的工作簿，可以使用read.xlsx2()，该函数用Java来运行更加多的处理过程，可获得可观的质量提升
# 也有其他包可用于处理Excel文件：XLConnect包(依赖于Java)和openxlsx包，这些包也可创建Excel文件

# 导出Excel电子表格：xlsx包
# 如 write.xlsx(mydata, 'mydata.xlsx')
# 将mydata数据框保存到当前工作目录下的Excel文件mydata.xlsx的工作表(默认是Sheet 1)中
# 默认情况下，数据集中的变量名称会被作为电子表格头部，行名称会放在电子表格的第一列，函数会覆盖已有原文件

# 从带分隔符的文本文件导入数据：
# 可以使用read.table()函数，此函数可读入一个表格格式的文件并将其保存为一个数据框
# 语法为 read.table(file, options) -> mydataframe
# 其中file是一个带分隔符的ASCII文本文件，options是控制如何处理数据的选项，常见的选项有：
# header 表示文件是否在第一行包含了变量名的逻辑型变量
# sep 分开数据值的分隔符，默认为sep=''(表示一个或多个空格、制表符、换行或回车)，
# sep=','读取用逗号分隔行内数据的文件，sep='\t'读取使用制表符分隔行内数据的文件
# row.names 用于指定一个或多个行标记符(指定某变量为行名，该列即不再有标签，导致数据会少一列)
# col.names 若数据文件的第一行不包括变量名(header=FALSE)，可以使用col.names指定一个包含变量名的字符向量
# 若header=FALSE，且col.names选项被省略，则变量会被分别命名为V1、V2，以此类推
# na.strings 用于表示缺失值的字符向量，如 na.strings=c('-9', '?') 在读取数据的时候把-9和?转换为NA
# colClasses 指定分配到每一列的类向量
# 如 colClasses=c('numeric', 'numeric', 'character', 'NULL', 'numeric')
# 把前俩列读取为数值型变量，把第三列读为字符型向量，跳过第四列，把第五列读取为数值型向量
# 若数据有多余五列，colClasses的值会被循环
# 在处理大型文本文件的时候，加上colClasses可以可观地提升处理速度
# quote 对有特殊字符的字符串划定界限，默认值是双引号"或单引号'
# skip 读取数据前跳过的行的数目，此选项在跳过头注释的时候比较有用
# stringsAsFactors 一个逻辑变量，标记字符向量是否需要转化成因子，默认为TRUE，除非它被colClasses所覆盖
# 在处理大型文本文件的时候，设置为stringsAsFactors=FALSE可以提升处理速度
# text 指定文字进行处理，若text被设置，file应该留空

# read.table('studentgrades.csv', header = TRUE, row.names = 'StudentID', sep = ',') -> grades
# read.table()默认把字符向量转化为因子
# read.table('studentgrades.csv', header = TRUE, row.names = 'StudentID', sep = ',', 
# colClasses = c('character', 'character', 'character', 'numeric', 'numeric', 
# 'numeric')) -> grades
# 注意：此时grades作为实数而不是整数
read.table(mytextfile, header = TRUE, sep = ',',
           colClasses = c('numeric', 'numeric', 'character',
                          NULL, 'numeric', NULL, 'character',
                          NULL, NULL, NULL)) -> my.data.frame
# 与NULL colClasses值相关的变量会被跳过不读取

# 导出符号分隔文本文件：
# write.table(x, outfile, sep = delimiter, quote = TRUE, na='NA')
# 其中，x是要输出的对象，outfile是目标文件
# 如 write.table(mydata, 'mydata.txt', sep = ',')
# 将mydata数据输出到当前目录下逗号分隔的mydata.txtx文件中
# 用路径(如 C:/myprojects/mydata.txt)可将输出文件保存到该地址下
# 用sep = '\t'替换sep = ','，数据就会保存到制表符分隔的文件中
# 默认情况下，字符串是放在引号中的

# 用连接来导入数据：
# 我们熟悉的是从计算机上已存在的文件中导入数据，R也提供了若干种通过连接connection来访问数据的机制
# 函数file()、gzfile()、bzfile()、xzfile()、unz()和url()可作为文件名参数使用
# 函数file()允许访问文件、剪贴板和C级别的标准输入
# 函数gzfile()、bzfile()、xzfile()和unz()允许读取压缩文件
# 函数url()允许通过一个含有http://、ftp://或file://的完整URL访问网络上的文件，还可以为HTTP和FTP连接指定代理
# 为了方便，用双引号围住的完整的URL也经常直接用来代替文件名使用，具体参见 ?file

# 数据集的标注：为了使结果更易解读
# 这种标注包括为变量名添加描述性的标签，以及为类别型变量中的编码添加值标签
# 然而R处理变量变量标签的能力有限

# 变量标签：
# 一种方法是将变量标签作为变量名，然后通过位置下标来访问该变量
c(1, 2, 3, 4) -> patientID
c(25, 34, 28, 52) -> age
c('Type1', 'Type2', 'Type1', 'Type1') -> diabetes
c('Poor', 'Improved', 'Excellent', 'Poor') -> status
data.frame(patientID, age, diabetes, status) -> patientdata
patientdata
'Age at hospitalization (in years)' -> names(patientdata)[2] # 将age重命名
patientdata
patientdata[2]

# 值标签：函数factor()可为类别型变量创建标签

# 处理数据对象的实用函数：
# length() 显示对象中元素/成分的数量
# dim() 显示某个对象的维度
# str() 显示某个对象的结构
# class() 显示某个对象的类或类型
# mode() 显示某个对象的模式
# names() 显示某对象中各成分的名称
# c(object, object, ...) 将对象合并入一个向量
# cbind(object, object, ...) 按列合并对象
# rbind(object, object, ...) 按行合并对象
# head() 列出某个对象的开始部分
# tail() 列出某个对象的最后部分
# ls() 显示当前的对象列表
# rm(object, object, ...) 删除一个或多个对象
# rm(list=ls())将删除当前工作环境中的几乎所有对象，而以句点.开头的隐藏对象将不受影响
# edit(object) -> newobject 编辑对象并另存为newobject
# fix(object) 直接编辑对象






