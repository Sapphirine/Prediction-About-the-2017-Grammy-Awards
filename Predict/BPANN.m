format long; clear; clc;

[Result,FTAT,FTHLT,FTAW,Tot_Weeks,Tot_Inf,Fsch,A] = textread('training79.txt','%f,%f,%f,%f,%f,%f,%f,%f',2208);

F = [FTAT,FTHLT,FTAW,Tot_Weeks,Tot_Inf,Fsch,A]';
[input,minI,maxI] = premnmx(F);

[output,minO,maxO] = premnmx(Result);

net = newff(minmax(input),[16 1],{'logsig','purelin'},'traingdx'); 

net.trainparam.show = 80000;
net.trainparam.epochs = 80000;
net.trainparam.goal = 0.001;
net.trainParam.lr = 0.015;
net.trainParam.min_grad = 1e-8;

net = train(net,input,output');

%=============================


[TTAT,TTHLT,TTAW,TDayType,TWinter,Tsch,A] = textread('forecast79.txt','%f,%f,%f,%f,%f,%f,%f',644);

T = [TTAT,TTHLT,TTAW,TDayType,TWinter,Tsch,A]';
testInput = tramnmx(T,minI,maxI);

Y = sim(net,testInput);
Y = Y';

N = length(Y);
for i = 1:N
    YR(i) = minO + 0.5*(Y(i)+1)*(maxO - minO);
end
YR = YR';

save CNN_Net net;

%==============================
[GAS2,FTAT2,FTHLT2,FTAW2,FDayType2,FWinter2,Fsch2,A] = textread('training79.txt','%f,%f,%f,%f,%f,%f,%f,%f',2208);
F2 = [FTAT2,FTHLT2,FTAW2,FDayType2,FWinter2,Fsch2,A]';
testInput2 = tramnmx(F2,minI,maxI);

Y2 = sim(net,testInput2);
Y2 = Y2';

N2 = length(Y2);
for i = 1:N2
    YF(i) = minO + 0.5*(Y2(i)+1)*(maxO - minO);
end
YF=YF';