[y,fs]=audioread('audioFile.mp3');
%sound(y,fs);

figure;
plot(y);

sigma1=findSigma(0,y(:,1)');
sigma2=findSigma(20,y(:,1)');
stepsize=(sigma2-sigma1)/20;

snrs=[];
mses=[];
for s=sigma1:stepsize:sigma2
z=(s)*randn(size(y,1),size(y,2));
r=y+z;

snr=findSNR(s,y(:,1)');
ms=mse(r(:,1)',y(:,1)');
snrs=[snrs , snr];
mses=[mses , ms];
    

end

figure;

plot(snrs,mses);
title('Coherent Detection');
xlabel('SNR(DB)');
ylabel('MSE');
sound(r(:,1),fs);



