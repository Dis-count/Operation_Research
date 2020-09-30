clc;
clear;
syms x y;
f =(x+y)^2 + (x+1)^2 + (y+3)^2;

% һ�׵���:
fx = diff(f,x);
fy = diff(f,y);
% ���׵���:
fxx = diff(fx,x);
fyy = diff(fy,y);
fxy = diff(fx,y);
fyx = diff(fy,x);

grad_f1 = [fx;fy];    % ���ִ����󵼽���
grad_H2 = [fxx fxy;fyx fyy]; % ���ִ����󵼽���

% ��ͼ:ԭʼ3d����ͼ
x = -20:0.1:20;
y = -15:0.1:15;
[X,Y] = meshgrid(x,y); 
Z = (X+Y).^2 + (X+1).^2 + (Y+3).^2;
figure(1);
mesh(X,Y,Z);
xlabel('������x'); ylabel('������y'); zlabel('�ռ�����z');
hold on;
% ��ͼ:ԭʼ��
x0 = 10; y0 = -1.5;
z0 = (x0+y0)^2 + (x0+1)^2 + (y0+3)^2;
plot3(x0,y0,z0,'r*');
hold on       
       
acc = 0.001;  % ����
x = 10; 
y = -1.5;      % ��ʼ��
k = 0;         % �½�����

% ţ�ٷ�һ����λ��
fprintf('ţ���½���ʼ:\n')
while 1
    ans_tmp = [x;y] - eval(inv(grad_H2))*eval(grad_f1);
    acc_tmp = sqrt((ans_tmp(1)-x)^2 + (ans_tmp(2)-y)^2);
   	if acc_tmp <= acc
		fprintf('��ֵ����Ϊ:(%.5f,%.5f,%.5f)\n',ans_tmp(1),ans_tmp(2),f_tmp);
        fprintf('��������:%d\n',k);
        plot3(ans_tmp(1),ans_tmp(2),f_tmp,'r*');
        hold off;
		break;
	end
	x = ans_tmp(1);
	y = ans_tmp(2);
	f_tmp = (x+y)^2 + (x+1)^2 + (y+3)^2;
    plot3(x,y,f_tmp,'r*');
    hold on;
    k = k + 1;  % ������
end

