%--------------------------------------------------------------------------
%   ��ʼ�� initialization
%--------------------------------------------------------------------------
clear;clc;
%-------------------�׶ص���ǿ��Ԥ�����׶ص�������3-5������  London area, non-london area at the same time 3-5 scale----------------
%--------------------------------------------------------------------------
%   �������� set parameters
%--------------------------------------------------------------------------
%---�׶�---London
N = 9300000;                                                               %�˿�����(�׶�) total population
E = 0;                                                                     %Ǳ����(�׶�) exposed 
I = 2;                                                                     %��Ⱦ��(�׶�) infected
S = N - I;                                                                 %�׸���(�׶�) suspectible
R = 0;                                                                     %������(�׶�) recovered
Z = 2;                                                                     %�ۻ��ĸ�Ⱦ����(�׶�) cumulative infected cases 
M = 2;                                                                     %��֢��Ⱦ����(�׶�) mild cases
C = 0;                                                                     %����֢��Ⱦ����(�׶�) serious cases
D = 0;                                                                     %��������(�׶�) death toll
Q = 0;                                                                     %�ܸ�Ⱦ����(�׶�) infected cases
%---���׶�---non-london
N1 = 57190000;                                                             %�˿�����(���׶�) total population
E1 = 0;                                                                    %Ǳ����(���׶�) exposed
I1 = 3;                                                                    %��Ⱦ��(���׶�) infected
S1 = N1 - I1;                                                              %�׸���(���׶�) suspectible
R1 = 0;                                                                    %������(���׶�) recovered
Z1 = 3;                                                                    %�ۻ��ĸ�Ⱦ����(���׶�) cumulative infected cases
M1 = 3;                                                                    %��֢��Ⱦ����(���׶�) mild infected cases 
C1= 0;                                                                     %����֢��Ⱦ����(���׶�) serious cases 
D1 = 0;                                                                    %��������(���׶�) death toll
Q1 = 0;                                                                    %�ܸ�Ⱦ����(���׶�) total infected cases
%---�ܼ�---UK
E2 = 0;                                                                    %Ǳ����(Ӣ���ܼ�) exposed
I2 = 0;                                                                    %��Ⱦ��(Ӣ���ܼ�) infected
R2 = 0;                                                                    %������(Ӣ���ܼ�) recovered
Z2 = 0;                                                                    %�ۻ��ĸ�Ⱦ����(Ӣ���ܼ�) cumulative infected cases
M2 = 0;                                                                    %��֢��Ⱦ����(Ӣ���ܼ�) mild cases
D2 = 0;                                                                    %��������(Ӣ���ܼ�)  death toll
C2= 0;                                                                     %����֢��Ⱦ����(Ӣ���ܼ�) serious cases
Q2 = 0;                                                                    %�ܸ�Ⱦ����(Ӣ���ܼ�) total infected cases

%Ӣ����ʵ��Ⱦ���� The true infected cases in the UK
II = [3,5,7,8,9,9,9,9,9,9,9,9,9,9,9,9,13,13,13,13,16,20,23,36,39,51,87,116,164,209,278,321,383,460,590,798,1140,1391,1543,1950,2626,3269,3983,5018,5684,6650,8077,9529,11658,14543,17089,19522,22141,25150];

r = 3;                                                                     %��Ⱦ�߽Ӵ��׸��ߵ����� the number of persons infected who have been exposed to susceptible persons
B = 0.05249;                                                               %��Ⱦ���� transmission probability
a = 1/6;                                                                   %Ǳ����ת��Ϊ��Ⱦ�߸��� probability of exposed to infected
r2 = 14;                                                                   %Ǳ���߽Ӵ��׸��ߵ����������׶أ�the number of exposed to susceptible non-London
r3 = 15;                                                                   %Ǳ���߽Ӵ��׸��ߵ��������׶أ�the number of exposed to susceptible London
B2 = 0.05249;                                                              %Ǳ���ߴ�Ⱦ�����˵ĸ��� The probability of infected to a normal person
y = 0.283;                                                                 %Ǳ���������� recovered rate of exposed
hospital = 1000;                                                           %��λ�����׶أ�hospital bed number London
hospital_out = 0;                                                          %ҽԺ֮�������֢���׶أ�serious cases out of hospital London
hospital1 = 1000;                                                          %��λ�������׶أ�hospital bed number non-London
hospital_out1 = 0;                                                         %ҽԺ֮�������֢�����׶أ�serious cases out of hospital non-London
h = 0.2;                                                                   %ҽԺ�ڵĿմ�λ���� the proportion of empty beds in hospital
j = 1;                                                                     %ҽԺ�ڵļ��ұ��� proportion of squeeze in hospitals
mild = 0.8;                                                                %��֢���� proportion of mild cases
critical = 0.061;                                                          %Σ�ر��� proportion of serious cases
severe_critical = 0.199;                                                   %����Σ�ر��� proportion of critical cases
ym = 1/7;                                                                  %��֢����ʱ����λ��7�� median recovery time for mild cases is 7 days
yhc = 1/13;                                                                %ҽԺ������֢����ʱ����λ��14�� median recovery time for severe cases is 14 days in hospital
yac = 1/18;                                                                %ҽԺ����������֢����ʱ��21�� ecovery time of aged patients with serious diseases is 21 days in hospital
yoc = 1/42;                                                                %ҽԺ������֢����ʱ��42�� recovery time of aged patients with serious diseases is 42 days out of hospital
ac = 1/7;                                                                  %����֢״����֢һ��ʱ�� Symptoms were detected up to a week after serious illness
dhc = 1/21;                                                                %ҽԺ������֢������λ��28-7�� Median number of death in hospital is 28 to 7 days
dac = 1/14;                                                                %ҽԺ��������������14�� serious to death is 4 days in hospital
doc = 1/4;                                                                 %ҽԺ������֢����4�� serious to death is 4 days out of hospital
old = 0.18;                                                                %���仯���� aging ratio
i = 0.88;                                                                  %�����ʣ��׶أ� Isolation rate London
i1 =0.94;                                                                  %�����ʣ����׶أ�Isolation rate non-London
u = 5;                                                                     %�����Ͻ� Zoom in the upper bound
d = 3;                                                                     %�����½� Zoom in the lower bound

T = 1:350;
for idx = 1:length(T)-1
    %ÿ�����ܶԷ��׶ص����ĽӴ�������һ���任3-5-3-5 every two weeks, the number of non-London contacts is changed to 3-5-3-5
    r2(idx+1) = r2(idx);
    r3(idx+1) = r3(idx);
    if idx >= 466
        r2(idx+1) = d;
    elseif idx >= 445
        r2(idx+1) = u;
    elseif idx >= 424
        r2(idx+1) = d;
    elseif idx >= 403
        r2(idx+1) = u;
    elseif idx >= 382
        r2(idx+1) = d;
    elseif idx >= 361
        r2(idx+1) = u;
    elseif idx >= 340
        r2(idx+1) = d;
    elseif idx >= 319
        r2(idx+1) = u;
    elseif idx >= 298
        r2(idx+1) = d;
    elseif idx >= 277
        r2(idx+1) = u;
    elseif idx >= 256
        r2(idx+1) = d;
    elseif idx >= 235
        r2(idx+1) = u;
    elseif idx >= 214
        r2(idx+1) = d;
    elseif idx >= 193
        r2(idx+1) = u;
    elseif idx >= 172
        r2(idx+1) = d;
    elseif idx >= 151
        r2(idx+1) = u;
        if hospital1 <= 125689
            hospital1 = hospital1 + 1150;
        end
    elseif idx >= 130
        r2(idx+1) = d;
        if hospital1 <= 125689
            hospital1 = hospital1 + 1150;
        end
    elseif idx >= 109
        r2(idx+1) = u;
       if hospital1 <= 125689
            hospital1 = hospital1 + 1150;
        end
    elseif idx >= 88
        r2(idx+1) = d;
        if hospital1 <= 125689
            hospital1 = hospital1 + 1150;
        end
    elseif idx >= 67
        r2(idx+1) = u;
        if h <= 0.6
            h = h +0.01;
        end
        if hospital <= 41900
            hospital = hospital + 1110;
        end
         if hospital1 <= 125689
            hospital1 = hospital1 + 1150;
        end
    elseif idx >= 46                                                       %�Զ�������Ϊ��׼��46�պ����¶�ʮ���ս���������ͨ��ʩ from February 7, restrictions was imposed for 46 days
        if r2(idx) ~= 3                                                    %ǿ��Ԥ�£���ͨ����ǿ��10��3����ȡ���ƺ�ÿ�����1���� Under the strong intervention, the circulation restriction was  from 10 to 3, and the restriction was reduced by 1 person per day
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
    elseif idx>=35    %�Զ�������Ϊ��׼��35�պ�����һʮ���ս���һ������ͨ���ƴ�ʩ from February 7, restrictions on circulation was imposed on for 35 days
        i=1;  
        i1=1;
        j = 0.8;
        if h <= 0.6
            h = h +0.01;
        end
        if hospital <= 41900
            hospital = hospital + 1110;
        end
         if hospital1 <= 125689
            hospital1 = hospital1 + 1150;
        end
        if r2(idx) ~= 10                                                   %һ������ͨ��Ԥ�£���ͨ����ǿ��15��10����ȡ���ƺ�ÿ�����1���� With interventions, circulation restrictions were from 15 to 10, with 1 less people per day after the restriction
            r2(idx+1) = r2(idx)-1;
        end   
        if r3(idx) ~= 10                                                   %һ������ͨ��Ԥ�£���ͨ����ǿ��12��10����ȡ���ƺ�ÿ�����1���� Under intervention, circulation restriction was from 12 to 10, with 1 less person per day after the restriction
            r3(idx+1) = r3(idx)-1;
        end 
    end
    %---�׶�--- London
    %�׸��� susceptible
    S(idx+1) = S(idx) - r*B*S(idx)*(M(idx)+C(idx))/N(1) - r3(idx)*B2*S(idx)*i*E(idx)/N;
    %Ǳ���� exposed
    E(idx+1) = E(idx) + r*B*S(idx)*(M(idx)+C(idx))/N(1)-a*E(idx) + r3(idx)*B2*S(idx)*i*E(idx)/N-y(idx)*E(idx);
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
    %---���׶�--- non-London
    %�׸��� susceptible
    S1(idx+1) = S1(idx) - r*B*S1(idx)*(M1(idx)+C1(idx))/N1(1) - r2(idx)*B2*S1(idx)*i1*E1(idx)/N1;
    %Ǳ���� exposed
    E1(idx+1) = E1(idx) + r*B*S1(idx)*(M1(idx)+C1(idx))/N1(1)-a*E1(idx) + r2(idx)*B2*S1(idx)*i1*E1(idx)/N1-y(idx)*E1(idx);
    %��֢���� mild cases 
    M1(idx+1) = M1(idx) + a*E1(idx) - ym*M1(idx) - M1(idx)*(severe_critical/mild)*ac;     
    if C1(idx) > hospital1*h*j
    	%δ��סԺ������֢���� critical cases who were not hospitalized
        hospital_out1(idx) = C1(idx) - hospital1*h*j;                           
        %����֢���� serious cases 
        C1(idx+1) = C1(idx) + M1(idx)*(severe_critical/mild)*ac - yhc*hospital1*h*j*(1-old) - dhc*hospital1*h*j*(critical/severe_critical)*(1-old) - yac*hospital1*h*j*old - dac*hospital1*h*j*(critical/severe_critical)*old - yoc*hospital_out1(idx) - doc*hospital_out1(idx)*(critical/severe_critical);               
        %�ۼƸ�Ⱦ���� cumulative infected cases
        Z1(idx+1) = Z1(idx) + a*E1(idx);                                                                
        %��Ⱦ�� infected
        I1(idx+1) = M1(idx+1) + C1(idx+1);
        %���������� total deatth toll
        D1(idx+1) = D1(idx) + dhc*hospital1*h*j*(critical/severe_critical)*(1-old) + dac*hospital1*h*j*(critical/severe_critical)*old + doc*hospital_out1(idx)*(critical/severe_critical);                                         
        %���������� total recovered cases
        R1(idx+1) = R1(idx) + y(idx)*E1(idx) + ym*M1(idx) + yhc*hospital1*h*j*(1-old) +  yac*hospital1*h*j*old+yoc*hospital_out1(idx);          
        %�ܸ�Ⱦ�����ǽ������������������������� The total infected cases are the total recovered cases plus the total death toll
        Q1(idx+1) = R1(idx+1) + D1(idx+1);                                 
    else
        %δ��סԺ������֢���� critical cases who were not hospitalized
        hospital_out1(idx) = 0;
        %����֢���� serious cases 
        C1(idx+1) = C1(idx) + M1(idx)*(severe_critical/mild)*ac - yhc*C1(idx)*(1-old) - dhc*C1(idx)*(critical/severe_critical)*(1-old) - yac*C1(idx)*old - dac*C1(idx)*(critical/severe_critical)*old;
        %�ۼƸ�Ⱦ���� cumulative infected cases
        Z1(idx+1) = Z1(idx) + a*E1(idx);                                                                                                                                    
        %��Ⱦ�� exposed
        I1(idx+1) = M1(idx+1) + C1(idx+1);
        %���������� total death toll
        D1(idx+1) = D1(idx) + dhc*C1(idx)*(critical/severe_critical)*(1-old)+dac*C1(idx)*(critical/severe_critical)*old;                                        
        %���������� total recovered cases 
        R1(idx+1) = R1(idx) + y(idx)*E1(idx) + ym*M1(idx) + yhc*C1(idx)*(1-old)+ yac*C1(idx)*old;                   
        %�ܸ�Ⱦ�����ǽ�������������������������  The total infected cases are the total recovered cases plus the total death toll
        Q1(idx+1) = R1(idx+1) + D1(idx+1);                                   
    end
    %---�ܼƣ��׶�+���׶أ�--- total (London+non-London)
    E2(idx+1) = E(idx)+E1(idx);
    I2(idx+1) = I(idx)+I1(idx);
    Z2(idx+1) = Z(idx)+Z1(idx);
    D2(idx+1) = D(idx)+D1(idx);
    Q2(idx+1) = Q(idx)+Q1(idx);
    
    %����ÿ�������� calculate the number of regeneration per day
    Rt0(idx) = 1 + (log(Q(idx))/idx)*(2+4) + (log(Q(idx))/idx)^2 * (2*4);  %�׶� London
    Rt1(idx) = 1 + (log(Q1(idx))/idx)*(2+4) + (log(Q1(idx))/idx)^2 * (2*4);%���׶� non-London
    Rt2(idx) = 1 + (log(Q2(idx))/idx)*(2+4) + (log(Q2(idx))/idx)^2 * (2*4);%Ӣ���ܼ� UK
     if idx<=54
        Rt3(idx) = 1 + (log(II(idx))/idx)*(2+4) + (log(II(idx))/idx)^2 * (2*4); %��ʵӢ����� real cases in UK
    end
end

%Basic reproduction number
% T1 = 1:350;
% plot(T1(9:349),Rt2(9:349));grid on;hold on;
% plot(T(9:54),Rt3(9:54));grid on;hold on;
% legend('UK Basic reproduction number','UK Real Basic reproduction number');
%legend('Suppression Intervetion','Mitigation Intervetion','Multiplee Intervetion');

%plot(T,E,T,I,T,D,T,E1,T,I1,T,D1);grid on;
%legend('Daily expoesd population(London)','Daily infectious population(London)','Total deaths(London)','Daily expoesd population(UK non-London)','Daily infectious population(UK non-London)','Total deaths(UK non-London)')
plot(T,E2,T,I2,T,D2);grid on;
legend('Daily expoesd population(UK)','Daily infectious population(UK)','Total deaths(UK)')
hold on;
xlabel('Number of Days from 6th Feburary');ylabel('Number of People')


title('UK -- Multiplee Intervetion on 23rd March')