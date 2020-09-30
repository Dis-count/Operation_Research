% ģ���˻�о������ã�Rastrigin��С��̫���ˣ�
% �������Ҫ�������������������ܲ�������һ�����ӣ�
% ���Ҫ���ѵ���ȷ�⣬����ǿ���������

clc;
clear;
syms x y;
% ���ݺ������ʽ: f��Сֵ��0
f = 0.5 + ( (sin(x^2+y^2))^2 - 0.5 ) / ( 1+0.01*(x^2+y^2) )^2; 
% һ�׵���: Ϊ���ѵ��ݶ��½�׼��
fx = diff(f,x);
fy = diff(f,y);

% ԭʼͼ��:
x = -5:0.01:5;
y = -5:0.01:5;
[X,Y] = meshgrid(x,y);
Z = 0.5 + ( (sin(sqrt(X.^2+Y.^2))).^2 - 0.5 ) ./ ( 1+0.01*(X.^2+Y.^2) ).^2;
figure(1);
mesh(X,Y,Z);
xlabel('������x'); ylabel('������y'); zlabel('�ռ�����z');
hold on;
x0 = 1.29;
y0 = -4.62;
f_min = 0.5 + ( (sin(sqrt(x0^2+y0^2)))^2 - 0.5 ) / ( 1+0.01*(x0^2+y0^2) )^2;
plot3(x0,y0,f_min,'b*');
hold on;

% ��ʼ��:
% ϣ����Χ����: x��[-20,0.1,20] y��[-15,0,1,15]
x = 2.42;
y = -4.58;
f_min = eval(f);

fprintf('��֪:��ȷ��Сֵ����(0.0,0.0,0.0)\n')
fprintf('ģ���˻�ʼ:\n')
num = 2000;     % ÿ���¶��µ�������
T_max = 500;    % ��ʼ����¶�30000
T_min = 0.001;  % ��β��С�¶�0.01
Trate = 0.95;   % �¶��½�����0.95
n = 0;
re_heat = 2;     % �����»���
global_min = 0;  % ��¼���ֵ����Сֵ��
while T_max > T_min
    T_max = T_max*Trate;
    %fprintf('��ǰ�¶�:%.5f\n',T_max);
    while n < num
        x_tmp = x + round(rand,1)*round(rand()-0.5,2);
        y_tmp = y + round(rand,1)*round(rand()-0.5,2);
        if (x_tmp > -5 && x_tmp < 5) && (y_tmp > -5 && y_tmp < 5)
            f_tmp = 0.5 + ( (sin(x_tmp^2+y_tmp^2))^2 - 0.5 ) / ( 1+0.01*(x_tmp^2+y_tmp^2) )^2; 
            res = f_tmp - f_min;
            % ��ʵ��: �ҵ���С��ֵ��Ȼ�ø���!
            if res < 0
                f_min = f_tmp;
                global_min = f_min;  % ����϶���Խ��ԽС��!
                x = x_tmp;
                y = y_tmp;
                plot3(x,y,f_min,'r*');
                hold on 
            else
                % ��һ�����书��:
                if T_max < 30 && global_min < f_tmp
                    continue;
                end
                % ���ʵ�: û�ҵ���С��ֵ��������
                p = exp(-res/T_max);
                if rand() < p   
                    f_min = f_tmp;
                    x = x_tmp;
                    y = y_tmp;
                    plot3(x,y,f_min,'w*');
                    hold on;
                end
            end
        end
        n = n + 1;
    end
    % ������
    if T_max < 100 && re_heat > 0 
        fprintf('�¶�С��50,������!\n')
        T_max = T_max + 100;
        re_heat = re_heat - 1;
    end
end
fprintf('���Ƽ�Сֵ����Ϊ:(%.5f,%.5f,%.5f)\n', x, y, f_min);

% ���濪ʼ�ݶ��½���ȷ����:
% ��ʼ��:
acc = 0.0001;     % ����
study_step = 0.001; % ѧϰ��
k = 0; % �½�����
% �ݶ��½���ʼ:[x1,y1] = [x0,y0] - step*( fx(x0,y0),fy(x0,y0) )
% ͼ����һ���µ����࣬��Ծʽ�½���
fprintf('�ݶ��½���ȷ������ʼ:\n');
while eval(fx)~=0 | eval(fy)~=0 
	ans_tmp = [x,y] - study_step*[eval(fx),eval(fy)];
	acc_tmp = sqrt((ans_tmp(1)-x)^2 + (ans_tmp(2)-y)^2);
	if acc_tmp <= acc | k >= 5000
		fprintf('��ȷ��ֵ����Ϊ:(%.5f,%.5f,%.5f)\n',ans_tmp(1),ans_tmp(2),f_tmp);
        fprintf('��������:%d\n',k);
        plot3(ans_tmp(1),ans_tmp(2),f_tmp,'k.');
        hold off
		break;
	end
	x = ans_tmp(1);
	y = ans_tmp(2);
	f_tmp = eval(f);
    plot3(x,y,f_tmp,'k.')
    hold on;
    k = k + 1;  % ������
end
global_min