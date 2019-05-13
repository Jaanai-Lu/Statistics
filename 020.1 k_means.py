import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import seaborn as sns
import random
import sys

# 标准化
def norm(vec):
    return (vec - np.mean(vec)) / np.std(vec)

def get_feature_vector(filename):

    df = pd.read_csv(filename)
    col_list = df.columns.tolist()
    # strip()删除空白
    col_list = [col_name.strip() for col_name in col_list]
    df.columns = col_list
    # 为了全面了解数据集，让我们查看seaborn配对图
    sns.pairplot(df) 
    # 为了可视化聚类，从cars.csv文件的可用列中取出两列
    # 下面的可视化通过使用“hp”和“mpg”列完成的
    X = df["hp"].values
    Y = df["mpg"].values
    norm_X = norm(X)
    # shape[0]提取第一个维度
    norm_X = norm_X.reshape(norm_X.shape[0], 1)
    norm_Y = norm(Y)
    norm_Y = norm_Y.reshape(norm_Y.shape[0], 1)
    # np.hstack()沿着水平方向将数组堆叠起来
    feature_vec = np.hstack((norm_X, norm_Y))

    return feature_vec

def random_initialize(vec, K):
    """
        Takes a vector of size M X N and the no:of clusters required
        Returns a vector of size K X N by randomly selecting K rows
        from M rows
    """
    # 确定数据集中数据点的总数
    M = vec.shape[0]
    # 随机选择K个数据点作为初始质心
    # np.random.choice()从给定的1维数组中随机采样
    indices = np.random.choice(M, K)
    return vec[indices]

def cluster_assign(vec, cluster_centroids):
    """
        Takes 2 vectors as input:
            vec: of size M X N
            cluster_centroids: of size K X N
            
        Returns a vector of size (M,) whose elements range from [0, K-1], i.e.
        they belong to one of the K cluster centroids. It is calculated by taking
        the L2 norm of each row of vec with all of the K rows of cluster_centroids,
        and then finding the minimum one
    """
    M = vec.shape[0]
    K = cluster_centroids.shape[0]
    c = []
    for i in range(M):
        row = vec[i,:]
        # sys.maxsize为最大支持的长度
        min_val = sys.maxsize
        min_index = None
        for j in range(K):
            centroid = cluster_centroids[j,:]
            # np.linalg.norm()求范数，默认参数(矩阵整体元素平方和开根号，不保留矩阵二维特性）
            norm_val = np.square(np.linalg.norm(row - centroid))
            if norm_val < min_val:
                min_val = norm_val
                min_index = j
        c.append(min_index)
    c = np.array(c)
    return c

def compute_distortion_cost(cluster_elems, cluster_centroid):
    """
        Given cluster_elems vector of size: C X N, where C is some number,
        and cluster_centroid of size: (N,), this function computes the distortion
        cost function, which is:
        
            ||cluster_elems - cluster_centroid||^2
    """
    # 失真成本函数
    N = cluster_elems.shape[1]
    cluster_centroid = cluster_centroid.reshape(1, N)
    return np.square(np.linalg.norm(cluster_elems - cluster_centroid))

def move_centroid(vec, cluster_centroids, c):
    """
        Given 3 vectors:
            vec: of size M X N
            cluster_centroids: of size K X N
            c of size: M X 1
        
        For each cluster centroid 'lambda', this function computes the average
        of all elements in vec which belong to 'lambda' and returns a vector of
        size: K X N
        
        It also returns the total cost of the current system. Which is defined as
        the sum of averages of all elements belonging to a cluster
    """
    M = vec.shape[0]
    K = cluster_centroids.shape[0]
    N = cluster_centroids.shape[1]
    new_cluster_centroids = []
    total_cost = 0
    
    for i in range(K):
        cluster_elems = vec[(c == i).nonzero()]
        
        if cluster_elems.shape[0] == 0:
            print("[WARN] Cluster no: " + str(i) + " is not assigned to any example")
            # Don't change the centroid of this cluster, simply add it to new_cluster_centroids list
            # np.squeeze()删除数组形状中的单维度条目，即把shape中为1的维度去掉
            new_cluster_centroids = new_cluster_centroids + (np.squeeze(cluster_centroids[i,:]).tolist())
            
            """
                This case occurs when in cluster_assignment step, the cluster with
                index 'i' (i.e. ith cluster among the K clusters) is not assigned to
                any of the data points. This is very much possible if you imagine
                properly.
                
                In this situation, there is no point in calculating the distortion
                cost, nor is there is any point in moving this cluster centroid (since
                no points are assigned to this cluster). Therefore we simply continue.
                
                The consequence of this design is that the total distortion cost
                will be high, since we are unable to initialize the K-means properly.
                This is the reason why it is recommended to run the entire K-means
                multiple times.
                
                Note that this situation will can arise two dissimilar situations:
                (i) When the actual no:of clusters in the dataset are 'alpha' and
                you decide to set K to value > 'alpha' (most common scenario)
                (ii) When K < 'alpha', but initialization was wrong. Typically this
                won't occur frequently, but if were to occur it can be overcome to
                a certain extent by repeated initialization
            """
            continue
        
        cost = compute_distortion_cost(cluster_elems, cluster_centroids[i,:])
        total_cost = total_cost + cost
        
        new_cluster_pos = np.mean(cluster_elems, axis=0, keepdims=True)
        # 在开发一个程序时候，与其让它运行时崩溃，不如在它出现错误条件时就崩溃（返回错误）,这时候断言assert就显得非常有用
        assert new_cluster_pos.shape == (1, N) # Sanity check
        new_cluster_centroids = new_cluster_centroids + (np.squeeze(new_cluster_pos).tolist())
    
    total_cost = total_cost / M

    assert len(new_cluster_centroids) == (K * N) # Sanity check
    new_cluster_centroids = np.array(new_cluster_centroids).reshape(K, N)
    return new_cluster_centroids, total_cost

def should_terminate(cluster_centroids, new_cluster_centroids, epsilon):
    """
        Given 2 (cluster_centroid) arrays of size K X N, this function
        computes their L2 norm and returns true if it is less than epsilon
    """
    K = cluster_centroids.shape[0]
    result_arr = [] 
    for i in range(K):
        result = np.square(np.linalg.norm(cluster_centroids[i,:] - new_cluster_centroids[i,:]))
        result_arr.append(result)
    diff_arr = [result for result in result_arr if result > epsilon]
    return len(diff_arr) == 0

def plot_cluster_centroid(vec, cluster_centroids, title_suffix):
    """
        Given 2 arrays of size:
            vec: of size M X N
            cluster_cntroids: of size K X N
            
        This function plots the vec and cluster_centroids on the graph with
        different colors
    """
    
    N = vec.shape[1]
    assert N == 2
    x_vals = vec[:,0]
    y_vals = vec[:,1]
    clust_x_vals = cluster_centroids[:,0]
    clust_y_vals = cluster_centroids[:,1]
    fig = plt.figure()
    if title_suffix != None:
        plt.title("K-means (" + title_suffix + ")")
    else:
        plt.title("K-means")
    plt.scatter(x_vals, y_vals, color='g', marker='o')
    plt.scatter(clust_x_vals, clust_y_vals, color='r', marker='v', s=128)
    plt.show()

def categorize(vec, c):
    """
        Given 2 arrays of size:
            vec: of size M X N
            c: of size of size (M,)
            
        This function labels all the datapoints in 'vec'
        based on their clusters in 'c'
    """
    classes = np.unique(c)
    categories = []
    for class_label in classes:
        datapoints = vec[(c == class_label).nonzero()]
        categories.append(datapoints.tolist())
    return categories

def plot_clusters(vec, c):
    """
        Given 2 arrays of size:
            vec: of size M X N
            c: of size of size (M,)
            
        This function plots the clusters
    """
    
    import matplotlib.cm as cm
    N = vec.shape[1]
    assert N == 2
    
    categories = categorize(vec, c)

    fig = plt.figure()
    plt.title("Clusters formed by K-means")
    plt.show()
    # np.linspace()在指定的间隔内返回均匀间隔的数字
    colors = cm.rainbow(np.linspace(0, 1, len(categories)))
    for category, c in zip(categories, colors):
        category = np.array(category)
        x = category[:,0]
        y = category[:,1]
        plt.scatter(x, y, color=c)
        plt.show()
    
def plot_distortion_cost(cost_arr):
    fig = plt.figure()
    plt.plot(cost_arr)
    plt.xlabel("iterations")
    plt.ylabel("cost")
    plt.title("K-means progress (distortion cost function)")
    plt.show()
    

def k_means(vec, K=2, epsilon=10e-7, max_iters=1000, factor=10,
            plot_main_figs=False, plot_progress=False, plot_cost=False,
            print_desc=False):
    """
        Takes a vector of size M X N and the no:of clusters (K) required
        Returns a vector of size K X N
        
        Note: epsilon is the difference between new cluster centroids and the old
        ones. The inner loop of k-means will terminate when the difference falls
        below epsilon. 'max_iters' on the other hand will ensure that the inner loop
        will run no more times than 'max_iters'
    """
    if(print_desc):
        print("=" * 40)
        print("Starting K-means")
    
    cluster_centroids = random_initialize(vec, K)
    if plot_main_figs:
        plot_cluster_centroid(vec, cluster_centroids, "initial")
    
    cost_arr = []
    converged = False
    c = None
    
    for i in range(max_iters):
        if (print_desc and i % (max_iters/factor) == 0):
            print("Running iteration: " + str(i) + " ...")
        
        c = cluster_assign(vec, cluster_centroids)
        
        new_cluster_centroids, cost = move_centroid(vec, cluster_centroids, c)
        cost_arr.append(cost)
        
        yes = should_terminate(cluster_centroids, new_cluster_centroids, epsilon)
        
        cluster_centroids = new_cluster_centroids
        if plot_progress and (i % (max_iters/factor) == 0):
            plot_cluster_centroid(vec, cluster_centroids, "itr: " + str(i))
        
        if yes:
            if print_desc:
                print("Converged at iteration: " + str(i))
            converged = True
            break
            
    if not converged:
        print("[WARN] Max iterations reached, K-means did not converge yet. Forcefully terminating!")

    if plot_main_figs:
        plot_cluster_centroid(vec, cluster_centroids, "final")    
    
    if(print_desc):
        print("Min cost: " + str(cost_arr[-1]))
        print("=" * 40)
    
    if plot_cost:
        plot_distortion_cost(cost_arr)
        
    return cluster_centroids, cost_arr, c

filename = 'cars.csv'
feature_vec = get_feature_vector(filename)

print("Feature vector shape: " + str(feature_vec.shape))

iterations=5
min_cost = sys.maxsize
global_reduced_feature_vec = None
global_cost_arr = None
global_cluster_labels = None
K=16

for i in range(iterations):
    
    print("Running K-means " + str(i) + "th time ...")
    reduced_feature_vec, cost_arr, cluster_labels = k_means(feature_vec, K=K,
                                                            epsilon=10e-7, max_iters=1000,
                                                            factor=10, plot_main_figs=False,
                                                            plot_progress=False, plot_cost=False,
                                                            print_desc=False)
    
    print("Cost in itr: " + str(i) + " is: " + str(cost_arr[-1]))
    
    if cost_arr[-1] < min_cost:
        min_cost = cost_arr[-1]
        global_reduced_feature_vec = reduced_feature_vec
        global_cost_arr = cost_arr
        global_cluster_labels = cluster_labels

plot_cluster_centroid(feature_vec, global_reduced_feature_vec, None)
plot_clusters(feature_vec, global_cluster_labels)
plot_distortion_cost(global_cost_arr)
print("\n\nGlobal min cost: " + str(cost_arr[-1]))
print("Reduced feature vector shape: " + str(reduced_feature_vec.shape))
