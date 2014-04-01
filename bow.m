clear all;
clc;
ncluster = 10;
%%%%%%%读入数据
path_c = 'car feature/';
path_d = 'dinosaur feature/';
%恐龙
d_dir = [];
d_inf = [];
files_d = dir(strcat(path_d ,'*.txt'));
for i = 1:length(files_d)
    filepath = strcat(path_d,files_d(i).name);
    pic = textread(filepath,'','headerlines',1);
    pic = pic(:,1:128);
    d_dir = [d_dir;pic];
    inf = textread(filepath,'',1);
    inf = inf(1);
    d_inf = [d_inf,inf];
end
%汽车
c_dir = [];
c_inf = [];
files_c = dir(strcat(path_c ,'*.txt'));
for i = 1:length(files_c)
    filepath = strcat(path_c,files_c(i).name);
    pic = textread(filepath,'','headerlines',1);
    pic = pic(:,1:128);
    c_dir = [c_dir;pic];
    inf = textread(filepath,'',1);
    inf = inf(1);
    c_inf = [c_inf,inf];
end

dirs = [d_dir;c_dir];
infs = [d_inf,c_inf];

%%%%%%%kmeans 聚类，生成图像的向量表示
[idx, C] = kmeans(dirs,ncluster);
idx = idx';
codebook = unique(idx);
x = [];
bg = 1;
for i = 1:length(infs)
    cnt = infs(i);
    ed = bg + cnt - 1;
    temp = idx(bg:ed);
    picf = [];
    for jj = 1:length(codebook)
        tmp = codebook(jj);
        nn = sum(temp == tmp);
        picf = [picf,nn];
    end
    x = [x;picf];
    bg = ed + 1;
end
y = [zeros(1,95),ones(1,95)];

%%%%%%%svm 分类
X_test = [x(61:95,:);x(156:190,:)];
X_train = [x(1:60,:);x(96:155,:)];
y_test = [y(61:95),y(156:190)];
y_test = y_test';
y_train = [y(1:60),y(96:155)];
y_train = y_train';

model = svmtrain(y_train,X_train);
[predice_label,accuracy,dec_values] = svmpredict(y_test,X_test,model);