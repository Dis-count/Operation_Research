% ����Ⱥ: Schaffer����
% ˵��: ���������Сֵ������٣�����Ⱥû���κ����⣡��������Ҫ�ݶ��½����ѣ�

clc;
clear;
f = inline('0.5 + ( (sin(x.^2+y.^2)).^2 - 0.5 ) ./ ( 1+0.01*(x.^2+y.^2) ).^2','x','y');
% ��ʼ��: f(2.42,-4.58) = 64.3589

% ��ʼ����:
% Ⱥ�����200��;Ⱥ����30������
maxgen = 200;
popsize = 30;  
% Ȩ�ز�����ʼ��
w = 1.0;
c1 = 1.49445;
c2 = 1.49445;
% �����ٶȺ�λ�õķ�Χ
Vmax = 1;
Vmin = -1;
popmax = 5;
popmin = -5;

% ��ʼ���ٶȺ�λ��
vx = (rand(1,popsize)-0.5)*2;      % �ٶ�vx��vy��[-1,1]֮��:��һ��ȫ��x����,�ڶ���ȫ��y����
vy = (rand(1,popsize)-0.5)*2;
popx = (rand(1,popsize)-0.5)*10;   % λ��popx��popy��[-5,5]֮��:ͬ��
popy = (rand(1,popsize)-0.5)*10;

% ��ʼ: ����(g)����λ�á�������Ӧ��
gbestx = popx;
gbesty = popy;
gfitness = f(popx,popy);
% ��ʼ: Ⱥ��(z)����λ�á�Ⱥ�������Ӧ��
[zmin,z] = min(gfitness);
zfitness = zmin;    % Ⱥ�������Ӧ��
zbestx = popx(z);
zbesty = popy(z);   % Ⱥ������λ��

gen = 0;  % ��������
fprintf('����Ⱥ������ʼ:\n')
while gen < maxgen
    % fprintf('��%d��ѭ��\n',gen);
    % ÿ�������ٶȸ���: �ٶ�һ�����£�
    for gv = 1:1:popsize
        vx(gv) = w*vx(gv) + c1*rand()*(gbestx(gv)-popx(gv)) + c2*rand()*(zbestx-popx(gv));
        % vx������ٶȴ�С����:
        if vx(gv) > Vmax
            vx(gv) = Vmax;
        elseif vx(gv) < Vmin
            vx(gv) = Vmin;
        end
        vy(gv) = w*vy(gv) + c1*rand()*(gbesty(gv)-popy(gv)) + c2*rand()*(zbesty-popy(gv));
        % vy������ٶȴ�С����:
        if vy(gv) > Vmax
            vy(gv) = Vmax;
        elseif vy(gv) < Vmin
            vy(gv) = Vmin;
        end
    end
    
    % ÿ�������λ�ø���: λ����Ȼһ���ڸ��£�����һ������Ҫ���õ�����λ�ã�
    for gp = 1:1:popsize
        popx(gp) = popx(gp) + 0.5*vx(gp);
        popy(gp) = popy(gp) + 0.5*vy(gp);
        % x��λ������:
        if popx(gp) > popmax
            popx(gp) = popmax;
        elseif popx(gp) < popmin
            popx(gp) = popmin;
        end
        % y��λ������:
        if popy(gp) > popmax
            popy(gp) = popmax;
        elseif popy(gp) < popmin
            popy(gp) = popmin;
        end
    end
    
    % ����ÿ�������µ���Ӧ��: ���㵫��һ������
    gfitness_tmp = f(popx,popy);
    
    % ÿ�����������λ�á������Ӧֵ����:
    for gi = 1:1:popsize
        if gfitness_tmp(gi) < gfitness(gi)
            % ���������Ӧ��ֵ���ͲŸ��¸�������λ��,���򲻱�!
            gbestx(gi) = popx(gi);
            gbesty(gi) = popy(gi);
            gfitness(gi) = gfitness_tmp(gi);
        end
    end
    
    % Ⱥ������λ�á������Ӧֵ����:
    [zmin,z] = min(gfitness);
    zfitness = zmin;    % Ⱥ�������Ӧ��
    zbestx = popx(z);
    zbesty = popy(z);   % Ⱥ������λ��!
   
    % ��һ������:
    gen = gen + 1; 
end
fprintf('����Ⱥ�������ļ�ֵ��:(%.5f,%.5f,%.5f)\n\n', zbestx, zbesty, zfitness);

if zfitness < 0.0001
    fprintf('����Ⱥ�����㹻��,���ٽ����ݶ��½�!\n');
    return ;
end

% ���濪ʼ�ݶ��½���ȷ����:
% ��ʼ��:
syms x y;
f = 0.5 + ( (sin(x^2+y^2))^2 - 0.5 ) / ( 1+0.01*(x^2+y^2) )^2
fx = diff(f,x);
fy = diff(f,y);
acc = 0.00001;     % ����
study_step = 0.001; % ѧϰ��
x = zbestx; 
y = zbesty;
k = 0; % �½�����
% �ݶ��½���ʼ:[x1,y1] = [x0,y0] - step*( fx(x0,y0),fy(x0,y0) )
% ͼ����һ���µ����࣬��Ծʽ�½���
fprintf('�ݶ��½���ȷ������ʼ:\n');
while eval(fx)~=0 | eval(fy)~=0 
	ans_tmp = [x,y] - study_step*[eval(fx),eval(fy)];
	acc_tmp = sqrt((ans_tmp(1)-x)^2 + (ans_tmp(2)-y)^2);
	if acc_tmp <= acc
		fprintf('��ȷ��ֵ����Ϊ:(%.5f,%.5f,%.5f)\n',ans_tmp(1),ans_tmp(2),f_tmp);
        fprintf('��������:%d\n',k);
        %plot3(ans_tmp(1),ans_tmp(2),f_tmp,'k.');
        %hold off
		break;
	end
	x = ans_tmp(1);
	y = ans_tmp(2);
	f_tmp = eval(f);
    %plot3(x,y,f_tmp,'k.')
    %hold on;
    k = k + 1;  % ������
end



