%--------------------------------------------------------------------------
%   ��ʼ��
%--------------------------------------------------------------------------
clear;clc;
%-------------------�׶ص����ͷ��׶ص���ǿ��Ԥ Strong intervention in London and non-london areas----------------
%--------------------------------------------------------------------------
%   ��������
%--------------------------------------------------------------------------
%---�׶�---London
N = 9300000;                                                               %�˿�����(�׶�)Total population
E = 0;                                                                     %Ǳ����(�׶�) Exposed
I = 2;                                                                     %��Ⱦ��(�׶�) infected
S = N - I;                                                                 %�׸���(�׶�) Susceptible
R = 0;                                                                     %������(�׶�) Recovered
Z = 2;                                                                     %�ۻ��ĸ�Ⱦ����(�׶�) infected cases
M = 2;                                                                     %��֢��Ⱦ����(�׶�) mild cases
C = 0;                                                                     %����֢��Ⱦ����(�׶�) serious cases
D = 0;                                                                     %��������(�׶�) death
Q = 0;                                                                     %�ܸ�Ⱦ����(�׶�) total infected cases
A = 0;                                                                     %����ȷ������(�׶�) Number of self-healing
%---���׶�--- non-London area
N1 = 57190000;                                                             %�˿�����(���׶�) total population
E1 = 0;                                                                    %Ǳ����(���׶�) exposed 
I1 = 3;                                                                    %��Ⱦ��(���׶�) infected
S1 = N1 - I1;                                                              %�׸���(���׶�)susceptible
R1 = 0;                                                                    %������(���׶�) recovered
Z1 = 3;                                                                    %�ۻ��ĸ�Ⱦ����(���׶�)infected cases 
M1 = 3;                                                                    %��֢��Ⱦ����(���׶�)
C1= 0;                                                                     %����֢��Ⱦ����(���׶�)serious cases
D1 = 0;                                                                    %��������(���׶�)death toll
Q1 = 0;                                                                    %�ܸ�Ⱦ����(���׶�)total infected cases                   
%---�ܼ�---
E2 = 0;                                                                    %Ǳ����(Ӣ���ܼ�)exposed 
I2 = 0;                                                                    %��Ⱦ��(Ӣ���ܼ�)infected 
R2 = 0;                                                                    %������(Ӣ���ܼ�)recovered 
Z2 = 0;                                                                    %�ۻ��ĸ�Ⱦ����(Ӣ���ܼ�)infected cases 
M2 = 0;                                                                    %��֢��Ⱦ����(Ӣ���ܼ�)mild cases 
C2= 0;                                                                     %����֢��Ⱦ����(Ӣ���ܼ�)serious cases 
D2 = 0;                                                                    %��������(Ӣ���ܼ�) death toll
Q2 = 0;                                                                    %�ܸ�Ⱦ����(Ӣ���ܼ�) total infected cases 
W=0;                                                                       %ÿ�����������Ⱦ���� Daily increase in the total number of infections
DH=0;                                                                      %ҽԺ���������� Number of deaths in the hospital(London)
DO=0;                                                                      %ҽԺ���������� Number of deaths outside the hospital(London)
DH1=0;                                                                     %ҽԺ���������� Number of deaths in the hospital(non-London)
DO1=0;                                                                     %ҽԺ���������� Number of deaths outside the hospital(non-London)
DH2=0;                                                                     %ҽԺ���������� Number of deaths in the hospital(UK)
DO2=0;                                                                     %ҽԺ���������� Number of deaths outside the hospital(UK)
r = 3;                                                                     %��Ⱦ�߽Ӵ��׸��ߵ����� the number of persons infected who have been exposed to susceptible persons
B = 0.05249;                                                               %��Ⱦ���� infection probability
a = 1/6;                                                                   %Ǳ����ת��Ϊ��Ⱦ�߸��� probability of exposed to become infected 
r2 = 14;                                                                   %Ǳ���߽Ӵ��׸��ߵ����������׶أ�The number of exposed to susceptible non-London
r3 = 15;                                                                   %Ǳ���߽Ӵ��׸��ߵ��������׶أ�The number of exposed to susceptible London
B2 = 0.05249;                                                              %Ǳ���ߴ�Ⱦ�����˵ĸ��� probability of infected susceptible
y = 1/5;                                                                   %Ǳ���������� probability of recovered
h = 0.2;                                                                   %ҽԺ�ڵĿմ�λ���� Proportion of empty beds in the hospital
h_london = 41904;                                                          %Total number of beds in London
h_nonlondon = 125689;                                                      %Total number of beds in non-London area
ha_london = h_london*h;                                                    %Total number of beds available in London
ha_nonlondon = h_nonlondon*h;                                              %Total number of available beds in non-London area
hospital = 4000;                                                           %��λ�����׶أ�Initial number of beds in London
hospital_out = 0;                                                          %ҽԺ֮�������֢���׶أ�Number of moderately and severely ill outside London Hospital
hospital1 =12000;                                                          %��λ�������׶أ�Initial number of beds in non-London
hospital_out1 = 0;                                                         %ҽԺ֮�������֢�����׶أ�Number of moderately and severely ill outside non-London Hospital
j = 1;                                                                     %ҽԺ�ڵļ��ұ���  proportion of squeeze in hospitals
mild = 0.8;                                                                %��֢���� proportion of mild cases 
critical = 0.061;                                                          %Σ�ر��� proportion of serious cases 
severe_critical = 0.199;                                                   %����Σ�ر��� proportion of severe critical cases 
ym = 1/7;                                                                  %��֢����ʱ����λ��7�� median recovery time for mild cases is 7 days
yhc = 1/14;                                                                %ҽԺ������֢����ʱ����λ��14��  median recovery time for severe cases is 14 days in hospital
yac = 1/21;                                                                %ҽԺ����������֢����ʱ��21��  recovery time of aged patients with serious diseases is 21 days in hospital
yoc = 1/42;                                                                %ҽԺ������֢����ʱ��42�� recovery time of aged patients with serious diseases is 42 days out of hospital
ac = 1/7;                                                                  %����֢״����֢һ��ʱ�� Symptoms were detected up to a week after serious illness
dhc = 1/28;                                                                %ҽԺ������֢������λ��28�� Median number of death in hospital is 28 days
dac = 1/14;                                                                %ҽԺ��������������14�� serious to death for old aged patients is 14 days in hospital
doc = 1/4;                                                                 %ҽԺ������֢����4�� serious to death is 4 days out of hospital
old = 0.18;                                                                %���仯���� Aging ratio
i = 0.785;                                                                 %�����ʣ��׶أ�Isolation rate London
i1 =0.911;                                                                  %�����ʣ����׶أ�Isolation rate non-London
%True daily death toll
death1=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,2,3,7,7,9,10,28,43,65,81,115,158,194,250,285,359,208,694,877,1162,1455,1669,2043,2425,3095,3747,4461,5221,5865,6433,7471,8505,9608,10760,11599,12285,13029,14073,14915,15944,16879,17994,18492,19051,20223,21060,21787,22792,23635,24055,24393,25302,26097,26771];
T = 1:350;
for idx = 1:length(T)-1
    r2(idx+1) = r2(idx);
    r3(idx+1) = r3(idx);    
    if idx == 57                                                           %Day 57 Nightingale Hospital Completed with Increased Medical Resources
        h_london = h_london+4000;
        h_nonlondon = h_nonlondon+29000;
        ha_london = ha_london+4000;
        ha_nonlondon = ha_nonlondon+29000;
        hospital = hospital + 4000;
        hospital1 = hospital1 + 29000;
    end
    if idx >= 46                                                           %�Զ�������Ϊ��׼��46�պ����¶�ʮ���ս���������ͨ��ʩ from February 7, restrictions was imposed for 46 days
        if r2(idx) ~= 3                                                    %ǿ��Ԥ�£���ͨ����ǿ��10��3����ȡ���ƺ�ÿ�����1���� Under the strong intervention, the circulation restriction was  from 10 to 3, and the restriction was reduced by 1 person per day
            r2(idx+1) = r2(idx)-1;
            r3(idx+1) = r3(idx)-1;
        end
        if hospital <= ha_london
             hospital = hospital + 140;                                    %��ʱ�䲻�������ܴ�λ�� Increase the total number of beds over time
         end
         if hospital1 <= ha_nonlondon
             hospital1 = hospital1 + 360;
         end
    elseif idx>=35                                                         %�Զ�������Ϊ��׼��35�պ�����һʮ���ս���һ������ͨ���ƴ�ʩfrom February 7, restrictions on circulation was imposed on for 35 days
        i=0.8;                                                            
        i1=0.8;
         if hospital <= ha_london
             hospital = hospital + 140;                                    %��ʱ�䲻�������ܴ�λ��Increase the total number of beds over time
         end
         if hospital1 <= ha_nonlondon
             hospital1 = hospital1 + 360;
         end
        if r2(idx) ~= 10                                                   %һ������ͨ��Ԥ�£���ͨ����ǿ��15��10����ȡ���ƺ�ÿ�����1����% Under certain circulation intervention, the circulation limit is strong from 15 to 10, and one person per day is reduced after the limit is taken
            r2(idx+1) = r2(idx)-1;
        end   
        if r3(idx) ~= 10                                                   %һ������ͨ��Ԥ�£���ͨ����ǿ��12��10����ȡ���ƺ�ÿ�����1����% Under certain circulation intervention, the circulation limit is strong from 12 to 10, and one person per day is reduced after the limit is taken
            r3(idx+1) = r3(idx)-1;
        end 
    elseif idx>=1 
        if hospital <= ha_london
             hospital = hospital + 30;                                    %��ʱ�䲻�������ܴ�λ��
         end
          if hospital1 <= ha_nonlondon
             hospital1 = hospital1 + 90;
         end
    end
    %---�׶�---London
    %�׸��� susceptible
    S(idx+1) = S(idx) - r*B*S(idx)*(M(idx)+C(idx))/N(1) - r3(idx)*B2*S(idx)*i*E(idx)/N;
    %Ǳ���� exposed
    E(idx+1) = E(idx) + r*B*S(idx)*(M(idx)+C(idx))/N(1)-a*E(idx) + r3(idx)*B2*S(idx)*i*E(idx)/N-y(idx)*E(idx);
    %��֢���� mild cases
    M(idx+1) = M(idx) + a*E(idx) - ym*M(idx) - M(idx)*(severe_critical/mild)*ac;    
    % Number of beds available
    H(idx+1) = hospital*j;
    %�жϵ�ǰ�Ŀ����ô�λ���Ƿ��������� Determine whether the number of available beds meets the demand
    if C(idx) > hospital*j
        %δ��סԺ������֢�������� critical cases who were not hospitalized
    	hospital_out(idx) = C(idx) - hospital*j;      
        %����֢�������� number of patients with serious illness
        C(idx+1) = C(idx) + M(idx)*(severe_critical/mild)*ac - yhc*hospital*j*(1-old) - dhc*hospital*j*(critical/severe_critical)*(1-old) - yac*hospital*j*old - dac*hospital*j*(critical/severe_critical)*old - yoc*hospital_out(idx) - doc*hospital_out(idx)*(critical/severe_critical);              
        %�ۼƸ�Ⱦ���� Cumulative infected cases                               
        Z(idx+1) = Z(idx) + a*E(idx);   
        %��Ⱦ�� infected cases
        I(idx+1) = M(idx+1) + C(idx+1);
        %�ۼ��������� cumulative death toll
        D(idx+1) = D(idx) + dhc*hospital*j*(critical/severe_critical)*(1-old) + doc*hospital_out(idx)*(critical/severe_critical) + dac*hospital*j*(critical/severe_critical)*old;                                    
        %Daily deaths
        DD(idx+1) = dhc*hospital*j*(critical/severe_critical)*(1-old) + doc*hospital_out(idx)*(critical/severe_critical) + dac*hospital*j*(critical/severe_critical)*old;                                    
        DH(idx+1)=DH(idx)+dhc*hospital*j*(critical/severe_critical)*(1-old) + dac*hospital*j*(critical/severe_critical)*old;
        DO(idx+1)=DO(idx)+doc*hospital_out(idx)*(critical/severe_critical);
        %�ۼ��������� cumulative recovered cases
        R(idx+1) = R(idx) + y(idx)*E(idx) + ym*M(idx) + yhc*hospital*j*(1-old) + yac*hospital*j*old + yoc*hospital_out(idx);             
        %�ܸ�Ⱦ�����ǽ������������������������� The total number of infections is the total number of cures plus the total number of deaths
        Q(idx+1) = R(idx+1) + D(idx+1);                                  
        y(idx+1) = y(idx);
    else
        %δ��סԺ������֢�������� Number of critical patients who were not hospitalized
        hospital_out(idx) = 0;
        %����֢�������� serious cases
        C(idx+1) = C(idx) + M(idx)*(severe_critical/mild)*ac - yhc*C(idx)*(1-old) - dhc*C(idx)*(critical/severe_critical)*(1-old) - yac*C(idx)*old - dac*C(idx)*(critical/severe_critical)*old;
        %�ۼƸ�Ⱦ�� Cumulative infected cases                                      
        Z(idx+1) = Z(idx) + a*E(idx);    
        %��Ⱦ�� infected
        I(idx+1) = M(idx+1) + C(idx+1);
        %���������� cumulative death toll
        D(idx+1) = D(idx) + dhc*C(idx)*(critical/severe_critical)*(1-old) + dac*C(idx)*(critical/severe_critical)*old;                                       
        DH(idx+1)=DH(idx)+dhc*C(idx)*(critical/severe_critical)*(1-old) + dac*C(idx)*(critical/severe_critical)*old;
        DO(idx+1)=DO(idx);
        DD(idx+1) = dhc*C(idx)*(critical/severe_critical)*(1-old) + dac*C(idx)*(critical/severe_critical)*old;
        %���������� cumulative recovered cases
        R(idx+1) = R(idx) + y(idx)*E(idx) + ym*M(idx) + yhc*C(idx)*(1-old) + yac*C(idx)*old;            
        %�ܸ�Ⱦ�����ǽ������������������������� The total infected cases are the total recovered cases plus the total death toll
        Q(idx+1) = R(idx+1) + D(idx+1);                                   
        y(idx+1) = y(idx);
    end
    %---���׶�--- non-London
    %�׸��� susceptible
    S1(idx+1) = S1(idx) - r*B*S1(idx)*(M1(idx)+C1(idx))/N1(1) - r2(idx)*B2*S1(idx)*i1*E1(idx)/N1;
    %Ǳ���� exposed
    E1(idx+1) = E1(idx) + r*B*S1(idx)*(M1(idx)+C1(idx))/N1(1)-a*E1(idx) + r2(idx)*B2*S1(idx)*i1*E1(idx)/N1-y(idx)*E1(idx);
    %��֢����  mild cases 
    M1(idx+1) = M1(idx) + a*E1(idx) - ym*M1(idx) - M1(idx)*(severe_critical/mild)*ac;     
    % Number of beds available
    H1(idx+1) = hospital1*j;
    if C1(idx) > hospital1*j
    	%δ��סԺ������֢���� critical cases who were not hospitalized
        hospital_out1(idx) = C1(idx) - hospital1*j;                           
        %����֢���� serious cases 
        C1(idx+1) = C1(idx) + M1(idx)*(severe_critical/mild)*ac - yhc*hospital1*j*(1-old) - dhc*hospital1*j*(critical/severe_critical)*(1-old) - yac*hospital1*j*old - dac*hospital1*j*(critical/severe_critical)*old - yoc*hospital_out1(idx) - doc*hospital_out1(idx)*(critical/severe_critical);               
        %�ۼƸ�Ⱦ���� cumulative infected cases
        Z1(idx+1) = Z1(idx) + a*E1(idx);                                                                
        %��Ⱦ��  infected
        I1(idx+1) = M1(idx+1) + C1(idx+1);
        %����������
        D1(idx+1) = D1(idx) + dhc*hospital1*j*(critical/severe_critical)*(1-old) + dac*hospital1*j*(critical/severe_critical)*old + doc*hospital_out1(idx)*(critical/severe_critical);                                         
        DH1(idx+1)= DH1(idx)+dhc*hospital1*j*(critical/severe_critical)*(1-old) + dac*hospital1*j*(critical/severe_critical)*old ;
        DO1(idx+1)= DO1(idx)+doc*hospital_out1(idx)*(critical/severe_critical);
        DD1(idx+1)= dhc*hospital1*j*(critical/severe_critical)*(1-old) + dac*hospital1*j*(critical/severe_critical)*old + doc*hospital_out1(idx)*(critical/severe_critical);
        %����������  total deatth toll
        R1(idx+1) = R1(idx) + y(idx)*E1(idx) + ym*M1(idx) + yhc*hospital1*j*(1-old) +  yac*hospital1*j*old+yoc*hospital_out1(idx);          
        %�ܸ�Ⱦ�����ǽ������������������������� The total infected cases are the total recovered cases plus the total death toll
        Q1(idx+1) = R1(idx+1) + D1(idx+1);                                 
    else
        %δ��סԺ������֢���� critical cases who were not hospitalized
        hospital_out1(idx) = 0;
        %����֢���� serious cases 
        C1(idx+1) = C1(idx) + M1(idx)*(severe_critical/mild)*ac - yhc*C1(idx)*(1-old) - dhc*C1(idx)*(critical/severe_critical)*(1-old) - yac*C1(idx)*old - dac*C1(idx)*(critical/severe_critical)*old;
        %�ۼƸ�Ⱦ���� cumulative infected cases
        Z1(idx+1) = Z1(idx) + a*E1(idx);                                                                                                                                    
        %��Ⱦ�� infected
        I1(idx+1) = M1(idx+1) + C1(idx+1);
        %���������� total deatth toll
        D1(idx+1) = D1(idx) + dhc*C1(idx)*(critical/severe_critical)*(1-old)+dac*C1(idx)*(critical/severe_critical)*old; 
        DH1(idx+1)=DH1(idx)+dhc*C1(idx)*(critical/severe_critical)*(1-old)+dac*C1(idx)*(critical/severe_critical)*old;
        DO1(idx+1)=DO1(idx);
        DD1(idx+1)=dhc*C1(idx)*(critical/severe_critical)*(1-old)+dac*C1(idx)*(critical/severe_critical)*old; 
        %���������� total recovered cases
        R1(idx+1) = R1(idx) + y(idx)*E1(idx) + ym*M1(idx) + yhc*C1(idx)*(1-old)+ yac*C1(idx)*old;                   
        %�ܸ�Ⱦ�����ǽ������������������������� The total infected cases are the total recovered cases plus the total death toll
        Q1(idx+1) = R1(idx+1) + D1(idx+1);                                   
    end
    %---�ܼƣ��׶�+���׶أ�--- total cases in London and non-London
    E2(idx+1) = E(idx)+E1(idx);
    H2(idx+1) = H(idx)+H1(idx);
    C2(idx+1) = C(idx)+C1(idx);
    I2(idx+1) = I(idx)+I1(idx);
    Z2(idx+1) = Z(idx)+Z1(idx);
    D2(idx+1) = D(idx)+D1(idx);
    Q2(idx+1) = Q(idx)+Q1(idx);
    W(idx+1) = r*B*S(idx)*(M(idx)+C(idx))/N(1) + i*r2(idx)*B2*S(idx)*E(idx)/N + r*B*S1(idx)*(M1(idx)+C1(idx))/N1(1) + r2(idx)*B2*S1(idx)*i1*E1(idx)/N;
    DH2(idx+1)=DH(idx)+DH1(idx);
    DO2(idx+1)=DO(idx)+DO1(idx);
    DD2(idx+1)=DD(idx)+DD1(idx);
    %csvwrite('real_death.csv',death1)
    %csvwrite('pre_death.csv',D2)

    hospital_out2(idx+1) = hospital_out(idx)+hospital_out1(idx);
    
end

plot(T,E,T,I,T,D,T,E1,T,I1,T,D1);grid on;
legend('Daily expoesd population(London)','Daily infectious population(London)','Total deaths(London)','Daily expoesd population(UK non-London)','Daily infectious population(UK non-London)','Total deaths(UK non-London)')
%plot(T,E,T,I);grid on;
%legend('Daily expoesd population(UK)','Daily infectious population(UK)','Total deaths(UK)')
hold on;
xlabel('Number of Days from 6th Feburary');ylabel('Number of People')
title('UK -- Suppression Intervetion on 23rd March')