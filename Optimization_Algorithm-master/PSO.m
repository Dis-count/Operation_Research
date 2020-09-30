% ����Ⱥ����˼�룺https://www.cnblogs.com/21207-iHome/p/6062535.html
% ����˼·����Ϣ����Ṳ����һ���Ŷӵ���ʽ��������
% �Ŷ����Ա��Ϣ������ͬ����������һ���˹���ʱ����Ŀ���ǳ��û��ȫ����ʶ��

clc;
clear;
syms x y;
% ���ݺ������ʽ: f��Сֵ��0
f = 20 + x^2 + y^2 -10*(cos(2*pi*x) + cos(2*pi*y));

% �������ٶȷ�Χ�޶�:
xmax = 5;
xmin = -5;
vmax = 1;
vmin = -1;
% Ȩ�ز�����ʼ��:
w = rand()
c1 = 2;
c2 = 2;  % 1.49445
% ��Ϣ��������:
maxgen = 6000;
% ����������
siezpop = 3;

% 1��:
vx1 = 2*(rand()-0.5);
vy1 = 2*(rand()-0.5); % ��ʼ�ٶ�
x1 = 10*(rand()-0.5);
y1 = 10*(rand()-0.5); % ��ʼλ��
f1 = 20 + x1^2 + y1^2 -10*(cos(2*pi*x1) + cos(2*pi*y1));  % 1���ʼ��Ӧ��
% 2��:
vx2 = 2*(rand()-0.5);
vy2 = 2*(rand()-0.5); % ��ʼ�ٶ�
x2 = 10*(rand()-0.5);
y2 = 10*(rand()-0.5); % ��ʼλ��
f2 = 20 + x2^2 + y2^2 -10*(cos(2*pi*x2) + cos(2*pi*y2));  % 2���ʼ��Ӧ��
% 3��:
vx3 = 2*(rand()-0.5);
vy3 = 2*(rand()-0.5); % ��ʼ�ٶ�
x3 = 10*(rand()-0.5);
y3 = 10*(rand()-0.5); % ��ʼλ��
f3 = 20 + x3^2 + y3^2 -10*(cos(2*pi*x3) + cos(2*pi*y3));  % 3���ʼ��Ӧ��
gf = [f1,f2,f3];
gx = [x1,x2,x3];
gy = [y1,y2,y3];

% 1���ʼ���λ��:
gbestx1 = x1;
gbesty1 = y1;
% 2���ʼ���λ��:
gbestx2 = x2;
gbesty2 = y2;
% 3���ʼ���λ��:
gbestx3 = x3;
gbesty3 = y3;
% ��������λ��
[m,xy] = min(gf);
zbestx = gx(xy);
zbesty = gy(xy);

num = 1;
while num < maxgen
    % 1���ٶȸ���:
    vx1 = w*vx1 + c1*rand()*(gbestx1-x1) + c2*rand()*(zbestx-x1);
    vy1 = w*vy1 + c1*rand()*(gbesty1-y1) + c2*rand()*(zbesty-y1);
    % 2���ٶȸ���:
    vx2 = w*vx2 + c1*rand()*(gbestx2-x2) + c2*rand()*(zbestx-x2);
    vy2 = w*vy2 + c1*rand()*(gbesty2-y2) + c2*rand()*(zbesty-y2);
    % 3���ٶȸ���:
    vx3 = w*vx3 + c1*rand()*(gbestx3-x3) + c2*rand()*(zbestx-x3);
    vy3 = w*vy3 + c1*rand()*(gbesty3-y3) + c2*rand()*(zbesty-y3);
    
    % 1��λ�ø���:
    x1_tmp = x1 + 0.5*vx1;
    y1_tmp = y1 + 0.5*vy1;
    % 2��λ�ø���:
    x2_tmp = x2 + 0.5*vx2;
    y2_tmp = y2 + 0.5*vy2;
    % 3��λ�ø���:
    x3_tmp = x3 + 0.5*vx3;
    y3_tmp = y3 + 0.5*vy3;
    gx_tmp = [x1_tmp,x2_tmp,x3_tmp];
    gy_tmp = [y1_tmp,y2_tmp,y3_tmp];
    
    % 3������Ӧ�ȸ���:
    f1_tmp = 20 + x1^2 + y1^2 -10*(cos(2*pi*x1) + cos(2*pi*y1));
    f2_tmp = 20 + x2^2 + y2^2 -10*(cos(2*pi*x2) + cos(2*pi*y2));
    f3_tmp = 20 + x3^2 + y3^2 -10*(cos(2*pi*x3) + cos(2*pi*y3));
    gf_tmp = [f1_tmp,f2_tmp,f3_tmp];
    
    % 1������λ�ø���:
    if f1_tmp < f1
        x1 = x1_tmp;
        y1 = y1_tmp;
    end
    % 2������λ�ø���:
    if f2_tmp < f2
        x2 = x2_tmp;
        y2 = y2_tmp;
    end
    % 3������λ�ø���:
    if f3_tmp < f3
        x3 = x3_tmp;
        y3 = y3_tmp;
    end
    
    % Ⱥ������λ�ø���:
    if min(gf_tmp) < m
        gf = gf_tmp;
        [m,xy] = min(gf);
        zbestx = gx(xy);
        zbesty = gy(xy);
    end
    num = num + 1
end
zbestx
zbesty
min(gf)


        