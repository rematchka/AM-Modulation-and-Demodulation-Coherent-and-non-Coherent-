[data ,fs]=audioread('wel.wav');
[dim , channel]=size(data);
 A = 2;
len=length(data);
%%phi=wct
phi=30*(3.14/180);
i=1;
X=zeros(11);
y=zeros(11);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% send signal %%%%%%%%%%%%%%%%%%
mt_signal=(A+data(:,1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% noise %%%%%%%%%%%%%%%%%%%%%%%%
for sigma = 0.1155:-0.010574:0.00976
random_nois = randn(len,channel);
random_nois=random_nois*sigma;
random_noise_1=randn(len,channel);
random_noise_1=random_noise_1*sigma;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% recieved signal %%%%%%%%%%%%%%%%
rt_signal_1=mt_signal(:,1)*cos(phi)+random_nois(:,1);
rt_signal_q=mt_signal(:,1)*sin(phi)+random_noise_1(:,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rt_signal_1=rt_signal_1(:,1)*2;
rt_signal_1=rt_signal_1(:,1).^2;
rt_signal_q=rt_signal_q(:,1)*2;
rt_signal_q=rt_signal_q(:,1).^2;

output=rt_signal_1(:,1)+rt_signal_q(:,1);
outputsqrt=sqrt(output(:,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%outputfinal(:,1)=outputsqrt(:,1)-A;

MSE1=(mean(outputsqrt(:,1)));
outputfinal=outputsqrt(:,1)-MSE1(:,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% signal power%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sig_power=(1/len)*(sum(data(:,1).^2));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SNR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

snr=10*log10(sig_power/(sigma.^2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MSE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MSE=(mean((data(:,1)-outputfinal(:,1)).^2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Saving Points For Plotting %%%%%%%%%%%%%%%%
X(i)=MSE;
y(i)=snr;
i=i+1;
end ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plotting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(y,X),title('Non-Coherent Detection');
xlabel('SNR')
ylabel('MSE')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Effecieny  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
eita=((sig_power.^2))/((A^2)+(sig_power.^2));
disp(eita);
