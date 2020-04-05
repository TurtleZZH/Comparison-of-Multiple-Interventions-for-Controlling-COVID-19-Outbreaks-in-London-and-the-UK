%--------------------------------------------------------------------------
%   初始化 initialization
%--------------------------------------------------------------------------
clear;clc;
%-------------------伦敦地区和非伦敦地区强干预 Strong intervention in London and non-london areas----------------
%--------------------------------------------------------------------------
%   参数设置
%--------------------------------------------------------------------------
%---伦敦---London
N = 9300000;                                                               %人口总数(伦敦) Total population 
E = 0;                                                                     %潜伏者(伦敦) Exposed 
I = 2;                                                                     %传染者(伦敦) infected            
S = N - I;                                                                 %易感者(伦敦)Susceptible 
R = 0;                                                                     %康复者(伦敦)Recovered 
Z = 2;                                                                     %累积的感染人数(伦敦)infected cases 
M = 2;                                                                     %轻症感染人数(伦敦)mild cases
C = 0;                                                                     %中重症感染人数(伦敦)serious cases
D = 0;                                                                     %死亡人数(伦敦)death
Q = 0;                                                                     %总感染人数(伦敦)total infected cases 
A = 0;                                                                     %估计确诊人数(伦敦)comfirmed cases 
%---非伦敦---non-London
N1 = 57190000;                                                             %人口总数(非伦敦)total population 
E1 = 0;                                                                    %潜伏者(非伦敦) exposed 
I1 = 3;                                                                    %传染者(非伦敦)infected 
S1 = N1 - I1;                                                              %易感者(非伦敦)susceptible
R1 = 0;                                                                    %康复者(非伦敦)recovered 
Z1 = 3;                                                                    %累积的感染人数(非伦敦)infected cases 
M1 = 3;                                                                    %轻症感染人数(非伦敦)mild cases
C1= 0;                                                                     %中重症感染人数(非伦敦)serious cases
D1 = 0;                                                                    %死亡人数(非伦敦)death toll
Q1 = 0;                                                                    
%---总计---total in UK
E2 = 0;                                                                    %潜伏者(英国总计)exposed 
I2 = 0;                                                                    %传染者(英国总计)infected 
R2 = 0;                                                                    %康复者(英国总计)recovered 
Z2 = 0;                                                                    %累积的感染人数(英国总计)infected cases 
M2 = 0;                                                                    %轻症感染人数(英国总计)mild cases 
C2= 0;                                                                     %中重症感染人数(英国总计)serious cases 
D2 = 0;                                                                    %死亡人数(英国总计) death toll
Q2 = 0;                                                                    %总感染人数(英国总计) total infected cases 

r = 3;                                                                     %感染者接触易感者的人数 the number of persons infected who have been exposed to susceptible persons
B = 0.05249;                                                               %传染概率 infection probability
a = 1/6;                                                                   %潜伏者转化为感染者概率 probability of exposed to become infected 
r2 = 14;                                                                   %潜伏者接触易感者的人数（非伦敦）The number of exposed to susceptible non-London
r3 = 15;                                                                   %潜伏者接触易感者的人数（伦敦）The number of exposed to susceptible London
B2 = 0.05249;                                                              %潜伏者传染正常人的概率  probability of infected susceptible
y = 0.283;                                                                 %潜伏者自愈率 probability of recovered
hospital = 1000;                                                           %床位数（伦敦）bed number London
hospital_out = 0;                                                          %医院之外的中重症（伦敦）serious cases outside of hospital London
hospital1 = 1000;                                                          %床位数（非伦敦）bed number non-London
hospital_out1 = 0;                                                         %医院之外的中重症（非伦敦）serious cases outside of hospital non-London
h = 0.2;                                                                   %医院内的空床位比例  proportion of empty beds in hospitals
j = 1;                                                                     %医院内的挤兑比例  proportion of squeeze in hospitals
mild = 0.8;                                                                %轻症比例  proportion of mild cases 
critical = 0.061;                                                          %危重比例 proportion of serious cases 
severe_critical = 0.199;                                                   %严重危重比例 proportion of severe critical cases 
ym = 1/7;                                                                  %轻症康复时间中位数7天 median recovery time for mild cases is 7 days
yhc = 1/13;                                                                %医院内中重症康复时间中位数14天 median recovery time for severe cases is 14 days in hospital
yac = 1/18;                                                                %医院内老龄中重症康复时间21天  recovery time of aged patients with serious diseases is 21 days in hospital
yoc = 1/42;                                                                %医院外中重症康复时间42天  recovery time of aged patients with serious diseases is 42 days out of hospital
ac = 1/7;                                                                  %发现症状到重症一周时间 Symptoms were detected up to a week after serious illness
dhc = 1/21;                                                                %医院内中重症死亡中位数28-7天 Median number of death in hospital is 28 to 7 days
dac = 1/14;                                                                %医院内老龄中重死亡14天 serious to death for old aged patients is 14 days in hospital
doc = 1/4;                                                                 %医院外中重症死亡4天 serious to death is 4 days out of hospital
old = 0.18;                                                                %老龄化比例 Aging ratio
i = 0.88;                                                                  %隔离率（伦敦）Isolation rate London
i1 =0.94;                                                                  %隔离率（非伦敦）Isolation rate non-London


T = 1:350;
for idx = 1:length(T)-1
    r2(idx+1) = r2(idx);
    r3(idx+1) = r3(idx);
    if idx >= 46                                                           %以二月七日为起准，46日后即三月二十三日进行限制流通措施 from February 7, restrictions was imposed for 46 days
        if r2(idx) ~= 3                                                    %强干预下，流通限制强从10到3，采取限制后每天减少1个人 Under the strong intervention, the circulation restriction was  from 10 to 3, and the restriction was reduced by 1 person per day
            r2(idx+1) = r2(idx)-1;
            r3(idx+1) = r3(idx)-1;
        end
        if h <= 0.6
            h = h +0.01;
        end
        if hospital <= 41900
            hospital = hospital + 1110;
        end
         if hospital1 <= 125689
            hospital1 = hospital1 + 1150;
        end
    elseif idx>=35                                                         %以二月七日为起准，35日后即三月一十二日进行一定的流通限制措施 from February 7, restrictions on circulation was imposed on for 35 days
        i=1;                                                               %三月二十一日后隔离率恢复为1  isolation rate was restored to 1 after March 21
        i1=1;
        j = 0.8;                                                           %普通流感或轻症造成可供中重症使用床位比例 proportion of beds available for patients with mild or severe illness
        if h <= 0.6
            h = h +0.01;                                                   %随时间不断增加可使用床位数 Increase the number of available beds over time
        end
        if hospital <= 41900
            hospital = hospital + 1110;                                    %随时间不断增加总床位数 Increase the total number of beds over time
        end
         if hospital1 <= 125689
            hospital1 = hospital1 + 1150;
        end
        if r2(idx) ~= 10                                                   %一定的流通干预下，流通限制强从15到10，采取限制后每天减少1个人 With interventions, circulation restrictions were from 15 to 10, with 1 less people per day after the restriction
            r2(idx+1) = r2(idx)-1;
        end    
        if r3(idx) ~= 10                                                   %一定的流通干预下，流通限制强从12到10，采取限制后每天减少1个人 Under intervention, circulation restriction was from 12 to 10, with 1 less person per day after the restriction
            r3(idx+1) = r3(idx)-1;
        end 
    end
    %---伦敦--- London
    %易感者 susceptible
    S(idx+1) = S(idx) - r*B*S(idx)*(M(idx)+C(idx))/N(1) - r3(idx)*B2*S(idx)*i*E(idx)/N;
    %潜伏者 exposed
    E(idx+1) = E(idx) + r*B*S(idx)*(M(idx)+C(idx))/N(1)-a*E(idx) + r3(idx)*B2*S(idx)*i*E(idx)/N-y(idx)*E(idx);
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
    %---非伦敦--- non-London
    %易感者 susceptible
    S1(idx+1) = S1(idx) - r*B*S1(idx)*(M1(idx)+C1(idx))/N1(1) - r2(idx)*B2*S1(idx)*i1*E1(idx)/N1;
    %潜伏者 exposed
    E1(idx+1) = E1(idx) + r*B*S1(idx)*(M1(idx)+C1(idx))/N1(1)-a*E1(idx) + r2(idx)*B2*S1(idx)*i1*E1(idx)/N1-y(idx)*E1(idx);
    %轻症人数 mild cases 
    M1(idx+1) = M1(idx) + a*E1(idx) - ym*M1(idx) - M1(idx)*(severe_critical/mild)*ac;     
    if C1(idx) > hospital1*h*j
    	%未能住院的中重症患者 critical cases who were not hospitalized
        hospital_out1(idx) = C1(idx) - hospital1*h*j;                           
        %中重症人数 serious cases 
        C1(idx+1) = C1(idx) + M1(idx)*(severe_critical/mild)*ac - yhc*hospital1*h*j*(1-old) - dhc*hospital1*h*j*(critical/severe_critical)*(1-old) - yac*hospital1*h*j*old - dac*hospital1*h*j*(critical/severe_critical)*old - yoc*hospital_out1(idx) - doc*hospital_out1(idx)*(critical/severe_critical);               
        %累计感染人数 cumulative infected cases
        Z1(idx+1) = Z1(idx) + a*E1(idx);                                                                
        %感染者 infected
        I1(idx+1) = M1(idx+1) + C1(idx+1);
        %总死亡人数 total deatth toll
        D1(idx+1) = D1(idx) + dhc*hospital1*h*j*(critical/severe_critical)*(1-old) + dac*hospital1*h*j*(critical/severe_critical)*old + doc*hospital_out1(idx)*(critical/severe_critical);                                         
        %总治愈人数 total recovered cases
        R1(idx+1) = R1(idx) + y(idx)*E1(idx) + ym*M1(idx) + yhc*hospital1*h*j*(1-old) +  yac*hospital1*h*j*old+yoc*hospital_out1(idx);          
        %总感染人数是将总治愈人数加上总死亡人数 The total infected cases are the total recovered cases plus the total death toll
        Q1(idx+1) = R1(idx+1) + D1(idx+1);                                 
    else
        %未能住院的中重症患者 critical cases who were not hospitalized
        hospital_out1(idx) = 0;
        %中重症人数 serious cases 
        C1(idx+1) = C1(idx) + M1(idx)*(severe_critical/mild)*ac - yhc*C1(idx)*(1-old) - dhc*C1(idx)*(critical/severe_critical)*(1-old) - yac*C1(idx)*old - dac*C1(idx)*(critical/severe_critical)*old;
        %累计感染人数 cumulative infected cases
        Z1(idx+1) = Z1(idx) + a*E1(idx);                                                                                                                                    
        %感染者 exposed
        I1(idx+1) = M1(idx+1) + C1(idx+1);
        %总死亡人数 total death toll
        D1(idx+1) = D1(idx) + dhc*C1(idx)*(critical/severe_critical)*(1-old)+dac*C1(idx)*(critical/severe_critical)*old;                                        
        %总治愈人数 total recovered cases 
        R1(idx+1) = R1(idx) + y(idx)*E1(idx) + ym*M1(idx) + yhc*C1(idx)*(1-old)+ yac*C1(idx)*old;                   
        %总感染人数是将总治愈人数加上总死亡人数  The total infected cases are the total recovered cases plus the total death toll
        Q1(idx+1) = R1(idx+1) + D1(idx+1);                                   
    end
    %---总计（伦敦+非伦敦）--- total cases in London and non-London
    E2(idx+1) = E(idx)+E1(idx);
    I2(idx+1) = I(idx)+I1(idx);
    Z2(idx+1) = Z(idx)+Z1(idx);
    D2(idx+1) = D(idx)+D1(idx);
    Q2(idx+1) = Q(idx)+Q1(idx);
    
    %计算每日再生数 Calculate the number of regeneration per day
    Rt0(idx) = 1 + (log(Q(idx))/idx)*(2+4) + (log(Q(idx))/idx)^2 * (2*4);  %伦敦 London
    Rt1(idx) = 1 + (log(Q1(idx))/idx)*(2+4) + (log(Q1(idx))/idx)^2 * (2*4);%非伦敦 non-London
    Rt2(idx) = 1 + (log(Q2(idx))/idx)*(2+4) + (log(Q2(idx))/idx)^2 * (2*4);%英国总计 UK
end

T1 = 1:350;
plot(T1(9:349),Rt2(9:349));grid on;hold on;
%legend('UK Basic reproduction number')
%xlabel('Number of Days from 6th Feburary');ylabel('Number')

%plot(T,E,T,I,T,D,T,E1,T,I1,T,D1);grid on;
%legend('Daily expoesd population(London)','Daily infectious population(London)','Total deaths(London)','Daily expoesd population(UK non-London)','Daily infectious population(UK non-London)','Total deaths(UK non-London)')
plot(T,E2,T,I2,T,D2);grid on;
legend('Daily expoesd population(UK)','Daily infectious population(UK)','Total deaths(UK)')
hold on;
xlabel('Number of Days from 6th Feburary');ylabel('Number of People')





title('UK -- Suppression Intervetion on 23rd March')