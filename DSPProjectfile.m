%function [bits1] = ex16( infile1, infile2, N )
infile1='cleanspeech.wav'
infile2='mic1.wav'
N=256

% [s1,s2,fs1,fs2,bits1,bits2]=ex15(infile1,infile2)
%
% infile1, infile2 - .WAV input files
% N – frame size (in samples)
%
% s1,s2 – signals loaded from infile1 and infile2
% fs1,fs2 – sample rates of s1 and s2
% bits1, bits2 – bits per sample in each file
%
% Function loads infile1 and infile2, then displays
% records frame-by-frame. Computes average energy
% per sample in each file.
% [s1,s2,fs1,fs2,bits1,bits2]=ex14(infile1,infile2)
%
% infile1, infile2 - .WAV input files
% N – frame size (in samples)
%
% s1,s2 – signals loaded from infile1 and infile2
% fs1,fs2 – sample rates of s1 and s2
% bits1, bits2 – bits per sample in each file
%
% Function loads infile1 and infile2, then displays
% records frame-by-frame. 

%creates points for file 1
[s1,fs1]=audioread(infile1);
info1 = audioinfo(infile1);
bits1 = info1.BitsPerSample;

%creates points for file 2
[s2,fs2]=audioread(infile2);
info2 = audioinfo(infile2);
bits2 = info2.BitsPerSample;


l1=length(s1);
l2=length(s2);
M=min(l1,l2);
K=fix(M/N);

e=s1-s2;

for k = 1:K
% Compute indices for current frame
n = (1:N)+(N*(k-1));



% Signal 1
subplot(211);

plot(n,s1(n),'b',n,e(n),'g:');
msg=sprintf('%s Frame %d',infile1,k);
title(msg);
ylabel('Normalized Amplitude');
xlabel('Sample index');


E=(s1(n)'*s1(n))/N;
%power=sum(s1(n))./N
legend(sprintf('Norm Frame E %f', E));

%text (min(xlim), max(ylim)/2, '%f')
%, power
% Signal 2
subplot(212);
plot(n,s2(n),'b',n,e(n),'g:');
msg=sprintf('%s Frame %d',infile2,k);
title(msg);
ylabel('Normalized Amplitude');
xlabel('Sample index');

E2=(s2(n)'*s2(n))/N;
%power=sum(s1(n))./N
legend(sprintf('Noisy Norm Frame E %f', E2));

% Pause between frames, waiting for keypress
pause

k
numer=sum(s1(n))./N;
denom=(sum(s1(n)-s2(n)))./N;
numer/denom;
SNR=10*log10(abs(numer)/abs(denom))

numer=sum(s1)./N;
denom=sum(s1-s2)./N;
numer/denom;
SNR=10*log10(abs(numer)/abs(denom))
end