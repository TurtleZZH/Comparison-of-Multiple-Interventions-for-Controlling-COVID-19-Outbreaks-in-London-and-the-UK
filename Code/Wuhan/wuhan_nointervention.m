%--------------------------------------------------------------------------
%   ��ʼ�� initialization
%--------------------------------------------------------------------------
clear;clc;
%-----------------------�人��δ�����κθ�Ԥ��ʩ Wuhan no intervetion---------------------------
%--------------------------------------------------------------------------
%   �������� set parameters
%--------------------------------------------------------------------------
N = 10500000;                                                              %�˿����� total population
E = 0;                                                                     %Ǳ���� exposed 
I = 1;                                                                     %��Ⱦ�� infected
S = N - I;                                                                 %�׸��� suspectible
R = 0;                                                                     %������ recovered
Z = 1;                                                                     %�ۻ��ĸ�Ⱦ����(����֢״) cumulative infected cases
M = 1;                                                                     %��֢��Ⱦ����  mild cases 
C = 0;                                                                     %����֢��Ⱦ���� severe and critical cases 
D = 0;                                                                     %�������� death toll
Q = 0;                                                                     %�ܸ�Ⱦ���� infected cases

r = 3;                                                                     %��Ⱦ�߽Ӵ��׸��ߵ����� the number of persons infected who have been exposed to susceptible persons
B = 0.05249;                                                               %��Ⱦ���� transmission probability
a = 1/6;                                                                   %Ǳ����ת��Ϊ��Ⱦ�߸��� probability of exposed to infected
r2 = 15;                                                                   %Ǳ���߽Ӵ��׸��ߵ����� the number of exposed to susceptible
B2 = 0.05249;                                                              %Ǳ���ߴ�Ⱦ�����˵ĸ��� The probability of infected to a normal person
y = 0.283;                                                                 %Ǳ���������� recovered rate of exposed
hospital = 600;                                                            %��λ�� hospital bed number
hospital_out = 0;                                                          %ҽԺ֮�������֢ serious cases out of hospital
h = 0.23;                                                                  %ҽԺ�ڵĿմ�λ����(�ɹ��¹ڷ���ʹ�õĲ�����) the proportion of empty beds in hospital
j = 1;                                                                     %ҽԺ�ڵļ��ұ������ɹ�����֢ʹ�õĲ�������proportion of squeeze in hospitals
mild = 0.8;                                                                %��֢���� proportion of mild cases
critical = 0.061;                                                          %Σ�ر��� proportion of severe cases
severe_critical = 0.199;                                                   %����Σ�ر��� proportion of critical cases
ym = 1/7;                                                                  %��֢����ʱ����λ��7�� median recovery time for mild cases is 7 days
yhc = 1/13;                                                                %ҽԺ������֢����ʱ����λ��13�� median recovery time for severe cases is 13 days in hospital
yac = 1/18;                                                                %ҽԺ����������֢����ʱ��18�� recovery time of aged patients with serious diseases is 18 days in hospital
yoc = 1/42;                                                                %ҽԺ������֢����ʱ��42�� recovery time of aged patients with serious diseases is 42 days out of hospital
ac = 1/7;                                                                  %����֢״����֢һ��ʱ�� Symptoms were detected up to a week after serious illness
dhc = 1/21;                                                                %ҽԺ������֢������λ��21�� Median number of death in hospital is 21 days
dac = 1/14;                                                                %ҽԺ��������������14�� serious to death is 14 days in hospital
doc = 1/4;                                                                 %ҽԺ������֢����4�� serious to death is 4 days out of hospital
old = 0.2;                                                                 %���仯���� aging ratio
rate_d = 0;                                                                %������ mortality rate
R0 = 0;                                                                    %��ʵ������ Real basic regeneration number
R01 = 0;                                                                   %Ԥ�������� Predicted basic regeneration number
xx = 1;                                                                    %����rate�ı���
%���ڱ���ȷ��������Ԥ��ȷ�������ı��� The ratio of the number of diagnoses reported early to the number of diagnoses predicted
rate = [9.39880321685876,9.46087020967284,6.72384116045848,5.97098593825878,6.06741325713512,5.98176060148190,7.08667106239536,8.43895807545865,10.1276417044877,10,9,8.14455508411780,8.17081806598347,7.92698028780500,7.52557609085896,6.69478465802675,5.59843588083478,4.73667712618950,4.01223784100138,3.20919468843443,2.76046641117649,2.49667232925059,2.20851115697604,2.07183123248070,1.89346223012893,1.78467768403162,1.73001993809820,1.05197614754092];
%��ʵ��Ⱦ���� The actual number of infections
I111 = [45,62,121,189,258,363,425,495,572,618,698,1590,1905,2261,2639,3215,4109,5142,6384,8351,10117,11618,13603,14982,16902,18454,19558,32994,35991,37914,39462,41152,42752,44412,45027,45346,45660,46201,46607,47071,47441,47824,48137,48557,49122,49315,49426,49540,49671,49797,40871,49912,49948,49965,49978,49986,49991,49995,49999,50003,50004,50005,50005,50005,50005,50005,50005,50006,50006,50006,50006,50006,50006,50006,50006];

T = 1:350;
T1 = 1:300;
for idx = 1:length(T)-1
    r2(idx+1) = r2(idx);
    if idx>= 52
        hospital = 12000;
        h = 0.6;
    elseif idx>= 51
        hospital = 10000;
        h = h +0.01;
    elseif idx>= 50
        hospital = 9000;
        h = h +0.01;
    elseif idx>= 49
        hospital = 8700;
        h = h +0.01;
    elseif idx>= 48
        hospital = 8500;
        h = h +0.01;
    elseif idx>= 47
        hospital = 8300;
        j = 1;
        h = h +0.01;
    elseif idx>= 46
        hospital = 8100;
        h = h +0.01;
    elseif idx>= 45
        hospital = 8000;
        h = h +0.01;
    elseif idx>= 44
        hospital = 7400;
        h = h +0.01;
    elseif idx>= 43
        hospital = 7000;
        h = h +0.01;
    elseif idx>=32                                                         %��ʮ���¶�ʮ����Ϊ��׼��32�պ�һ�¶�ʮ���ղ�����������ͨ��ʩ Starting from December 22nd, no circulation restriction measures will be implemented after January 32nd
        h = h +0.01;
        hospital = hospital + 200;
        if r2(idx) ~= 15                                                   %�޸�Ԥ�£��Ӵ��������ֲ��� Without intervention, the number of contacts remains the same
            r2(idx+1) = r2(idx)-2;
        end
    elseif idx>=28
        j = 0.5;
    end
    %�׸��� susceptible
    S(idx+1) = S(idx) - r*B*S(idx)*(M(idx)+C(idx))/N(1) - r2(idx)*B2*S(idx)*E(idx)/N;
    %Ǳ���� exposed
    E(idx+1) = E(idx) + r*B*S(idx)*(M(idx)+C(idx))/N(1)-a*E(idx) + r2(idx)*B2*S(idx)*E(idx)/N-y(idx)*E(idx);
    %��֢���� mild cases
    M(idx+1) = M(idx) + a*E(idx) - ym*M(idx) - M(idx)*(severe_critical/mild)*ac;   
    %�жϵ�ǰ�Ŀ����ô�λ���Ƿ��������� Determine whether the current number of available beds meets the requirements 
    if C(idx) > hospital*h*j
        %δ��סԺ������֢�������� critical cases who were not hospitalized
    	hospital_out(idx) = C(idx) - hospital*h*j;      
        %����֢�������� number of patients with serious illness
        C(idx+1) = C(idx) + M(idx)*(severe_critical/mild)*ac - yhc*hospital*h*j*(1-old) - dhc*hospital*h*j*(critical/severe_critical)*(1-old) - yac*hospital*h*j*old - dac*hospital*h*j*(critical/severe_critical)*old - yoc*hospital_out(idx) - doc*hospital_out(idx)*(critical/severe_critical);              
        %�ۼƸ�Ⱦ����   Cumulative infected cases                             
        Z(idx+1) = Z(idx) + a*E(idx);   
        %��Ⱦ�� infected cases
        I(idx+1) = M(idx+1) + C(idx+1);
        %�ۼ��������� cumulative death toll
        D(idx+1) = D(idx) + dhc*hospital*h*j*(critical/severe_critical)*(1-old) + doc*hospital_out(idx)*(critical/severe_critical) + dac*hospital*h*j*(critical/severe_critical)*old;                                    
        %�ۼ��������� cumulative recovered cases
        R(idx+1) = R(idx) + y(idx)*E(idx) + ym*M(idx) + yhc*hospital*h*j*(1-old) + yac*hospital*h*j*old + yoc*hospital_out(idx);             
        %�ܸ�Ⱦ�����ǽ������������������������� The total number of infections is the total number of people cured plus the total number of deaths
        Q(idx+1) = R(idx+1) + D(idx+1);                                  
        y(idx+1) = y(idx);
    else
        %δ��סԺ������֢�������� Number of critical patients who were not hospitalized
        hospital_out(idx) = 0;
        %����֢�������� serious cases
        C(idx+1) = C(idx) + M(idx)*(severe_critical/mild)*ac - yhc*C(idx)*(1-old) - dhc*C(idx)*(critical/severe_critical)*(1-old) - yac*C(idx)*old - dac*C(idx)*(critical/severe_critical)*old;
        %�ۼƸ�Ⱦ��  Cumulative infected cases                                       
        Z(idx+1) = Z(idx) + a*E(idx);    
        %��Ⱦ�� infected
        I(idx+1) = M(idx+1) + C(idx+1);
        %���������� cumulative death toll
        D(idx+1) = D(idx) + dhc*C(idx)*(critical/severe_critical)*(1-old) + dac*C(idx)*(critical/severe_critical)*old;                                       
        %���������� cumulative recovered cases
        R(idx+1) = R(idx) + y(idx)*E(idx) + ym*M(idx) + yhc*C(idx)*(1-old) + yac*C(idx)*old;            
        %�ܸ�Ⱦ�����ǽ������������������������� The total infected cases are the total recovered cases plus the total death toll
        Q(idx+1) = R(idx+1) + D(idx+1);                                   
        y(idx+1) = y(idx);
    end
    %�����ʼ��� Mortality calculation
    if idx >= 53
        A(idx) = Z(idx);
        rate_d(idx) = D(idx)/A(idx)*100;
    elseif idx >= 26
        A(idx) = Z(idx)/rate(xx);
        rate_d(idx) = D(idx)/A(idx)*100;
        xx = xx + 1;
    elseif idx >=1
        A(idx) = Z(idx)/10;
        rate_d(idx) = D(idx)/A(idx)*100; 
    end
    
    %����ÿ�������� Regeneration number calculation
    %��1��16����3��30�չ�����75�����ʵ������
    if idx<=75
        %��ʵ������ Real basic regeneration number calculation
       R01(idx) = 1 + (log(I111(idx))/(idx+25))*(2+4) + (log(I111(idx))/(idx+25))^2 * (2*4);
    end
    %Ԥ�������� Predicted basic regeneration number calculation
    R0(idx) = 1 + (log(Z(idx))/idx)*(2+4) + (log(Z(idx))/idx)^2 * (2*4);
end


plot(T,E,T,I,T,D);grid on;
legend('Daily expoesd population(Wuhan)','Daily infectious population(Wuhan)','Total deaths(Wuhan)')
hold on;
xlabel('Number of Days from 22nd December');ylabel('Number of People')

%���������� %Basic reproduction number
%plot(T(1:349),R0);grid on;
%plot(T(26:100),R01);grid on;
%legend('Predicted regeneration number','Real regeneration number')

%�����ʼ��� Mortality calculation
%plot(T(1:100),rate_d(1:100));grid on;
%legend('Mortality rate')

hold on;
title('Wuhan -- No Intervetion on 23rd January')