%--------------------------------------------------------------------------
%   初始化 initialization
%--------------------------------------------------------------------------
clear;clc;
%-----------------------武汉市未进行任何干预措施 Wuhan no intervetion---------------------------
%--------------------------------------------------------------------------
%   参数设置 set parameters
%--------------------------------------------------------------------------
N = 10500000;                                                              %人口总数 total population
E = 0;                                                                     %潜伏者 exposed 
I = 1;                                                                     %传染者 infected
S = N - I;                                                                 %易感者 suspectible
R = 0;                                                                     %康复者 recovered
Z = 1;                                                                     %累积的感染人数(出现症状) cumulative infected cases
M = 1;                                                                     %轻症感染人数  mild cases 
C = 0;                                                                     %中重症感染人数 severe and critical cases 
D = 0;                                                                     %死亡人数 death toll
Q = 0;                                                                     %总感染人数 infected cases

r = 3;                                                                     %感染者接触易感者的人数 the number of persons infected who have been exposed to susceptible persons
B = 0.05249;                                                               %传染概率 transmission probability
a = 1/6;                                                                   %潜伏者转化为感染者概率 probability of exposed to infected
r2 = 15;                                                                   %潜伏者接触易感者的人数 the number of exposed to susceptible
B2 = 0.05249;                                                              %潜伏者传染正常人的概率 The probability of infected to a normal person
y = 0.283;                                                                 %潜伏者自愈率 recovered rate of exposed
hospital = 600;                                                            %床位数 hospital bed number
hospital_out = 0;                                                          %医院之外的中重症 serious cases out of hospital
h = 0.23;                                                                  %医院内的空床位比例(可供新冠肺炎使用的病床数) the proportion of empty beds in hospital
j = 1;                                                                     %医院内的挤兑比例（可供中重症使用的病床数）proportion of squeeze in hospitals
mild = 0.8;                                                                %轻症比例 proportion of mild cases
critical = 0.061;                                                          %危重比例 proportion of severe cases
severe_critical = 0.199;                                                   %严重危重比例 proportion of critical cases
ym = 1/7;                                                                  %轻症康复时间中位数7天 median recovery time for mild cases is 7 days
yhc = 1/13;                                                                %医院内中重症康复时间中位数13天 median recovery time for severe cases is 13 days in hospital
yac = 1/18;                                                                %医院内老龄中重症康复时间18天 recovery time of aged patients with serious diseases is 18 days in hospital
yoc = 1/42;                                                                %医院外中重症康复时间42天 recovery time of aged patients with serious diseases is 42 days out of hospital
ac = 1/7;                                                                  %发现症状到重症一周时间 Symptoms were detected up to a week after serious illness
dhc = 1/21;                                                                %医院内中重症死亡中位数21天 Median number of death in hospital is 21 days
dac = 1/14;                                                                %医院内老龄中重死亡14天 serious to death is 14 days in hospital
doc = 1/4;                                                                 %医院外中重症死亡4天 serious to death is 4 days out of hospital
old = 0.2;                                                                 %老龄化比例 aging ratio
rate_d = 0;                                                                %死亡率 mortality rate
R0 = 0;                                                                    %真实再生数 Real basic regeneration number
R01 = 0;                                                                   %预测再生数 Predicted basic regeneration number
xx = 1;                                                                    %控制rate的变量
%早期报道确诊人数与预测确诊人数的比例 The ratio of the number of diagnoses reported early to the number of diagnoses predicted
rate = [9.39880321685876,9.46087020967284,6.72384116045848,5.97098593825878,6.06741325713512,5.98176060148190,7.08667106239536,8.43895807545865,10.1276417044877,10,9,8.14455508411780,8.17081806598347,7.92698028780500,7.52557609085896,6.69478465802675,5.59843588083478,4.73667712618950,4.01223784100138,3.20919468843443,2.76046641117649,2.49667232925059,2.20851115697604,2.07183123248070,1.89346223012893,1.78467768403162,1.73001993809820,1.05197614754092];
%真实感染人数 The actual number of infections
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
    elseif idx>=32                                                         %以十二月二十二日为起准，32日后即一月二十三日不进行限制流通措施 Starting from December 22nd, no circulation restriction measures will be implemented after January 32nd
        h = h +0.01;
        hospital = hospital + 200;
        if r2(idx) ~= 15                                                   %无干预下，接触人数保持不变 Without intervention, the number of contacts remains the same
            r2(idx+1) = r2(idx)-2;
        end
    elseif idx>=28
        j = 0.5;
    end
    %易感者 susceptible
    S(idx+1) = S(idx) - r*B*S(idx)*(M(idx)+C(idx))/N(1) - r2(idx)*B2*S(idx)*E(idx)/N;
    %潜伏者 exposed
    E(idx+1) = E(idx) + r*B*S(idx)*(M(idx)+C(idx))/N(1)-a*E(idx) + r2(idx)*B2*S(idx)*E(idx)/N-y(idx)*E(idx);
    %轻症人数 mild cases
    M(idx+1) = M(idx) + a*E(idx) - ym*M(idx) - M(idx)*(severe_critical/mild)*ac;   
    %判断当前的可利用床位数是否满足需求 Determine whether the current number of available beds meets the requirements 
    if C(idx) > hospital*h*j
        %未能住院的中重症患者人数 critical cases who were not hospitalized
    	hospital_out(idx) = C(idx) - hospital*h*j;      
        %中重症患者人数 number of patients with serious illness
        C(idx+1) = C(idx) + M(idx)*(severe_critical/mild)*ac - yhc*hospital*h*j*(1-old) - dhc*hospital*h*j*(critical/severe_critical)*(1-old) - yac*hospital*h*j*old - dac*hospital*h*j*(critical/severe_critical)*old - yoc*hospital_out(idx) - doc*hospital_out(idx)*(critical/severe_critical);              
        %累计感染人数   Cumulative infected cases                             
        Z(idx+1) = Z(idx) + a*E(idx);   
        %感染者 infected cases
        I(idx+1) = M(idx+1) + C(idx+1);
        %累计死亡人数 cumulative death toll
        D(idx+1) = D(idx) + dhc*hospital*h*j*(critical/severe_critical)*(1-old) + doc*hospital_out(idx)*(critical/severe_critical) + dac*hospital*h*j*(critical/severe_critical)*old;                                    
        %累计治愈人数 cumulative recovered cases
        R(idx+1) = R(idx) + y(idx)*E(idx) + ym*M(idx) + yhc*hospital*h*j*(1-old) + yac*hospital*h*j*old + yoc*hospital_out(idx);             
        %总感染人数是将总治愈人数加上总死亡人数 The total number of infections is the total number of people cured plus the total number of deaths
        Q(idx+1) = R(idx+1) + D(idx+1);                                  
        y(idx+1) = y(idx);
    else
        %未能住院的中重症患者人数 Number of critical patients who were not hospitalized
        hospital_out(idx) = 0;
        %中重症患者人数 serious cases
        C(idx+1) = C(idx) + M(idx)*(severe_critical/mild)*ac - yhc*C(idx)*(1-old) - dhc*C(idx)*(critical/severe_critical)*(1-old) - yac*C(idx)*old - dac*C(idx)*(critical/severe_critical)*old;
        %累计感染者  Cumulative infected cases                                       
        Z(idx+1) = Z(idx) + a*E(idx);    
        %感染者 infected
        I(idx+1) = M(idx+1) + C(idx+1);
        %总死亡人数 cumulative death toll
        D(idx+1) = D(idx) + dhc*C(idx)*(critical/severe_critical)*(1-old) + dac*C(idx)*(critical/severe_critical)*old;                                       
        %总治愈人数 cumulative recovered cases
        R(idx+1) = R(idx) + y(idx)*E(idx) + ym*M(idx) + yhc*C(idx)*(1-old) + yac*C(idx)*old;            
        %总感染人数是将总治愈人数加上总死亡人数 The total infected cases are the total recovered cases plus the total death toll
        Q(idx+1) = R(idx+1) + D(idx+1);                                   
        y(idx+1) = y(idx);
    end
    %死亡率计算 Mortality calculation
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
    
    %计算每日再生数 Regeneration number calculation
    %从1月16日至3月30日共计算75天的真实再生数
    if idx<=75
        %真实再生数 Real basic regeneration number calculation
       R01(idx) = 1 + (log(I111(idx))/(idx+25))*(2+4) + (log(I111(idx))/(idx+25))^2 * (2*4);
    end
    %预测再生数 Predicted basic regeneration number calculation
    R0(idx) = 1 + (log(Z(idx))/idx)*(2+4) + (log(Z(idx))/idx)^2 * (2*4);
end


plot(T,E,T,I,T,D);grid on;
legend('Daily expoesd population(Wuhan)','Daily infectious population(Wuhan)','Total deaths(Wuhan)')
hold on;
xlabel('Number of Days from 22nd December');ylabel('Number of People')

%再生数计算 %Basic reproduction number
%plot(T(1:349),R0);grid on;
%plot(T(26:100),R01);grid on;
%legend('Predicted regeneration number','Real regeneration number')

%死亡率计算 Mortality calculation
%plot(T(1:100),rate_d(1:100));grid on;
%legend('Mortality rate')

hold on;
title('Wuhan -- No Intervetion on 23rd January')