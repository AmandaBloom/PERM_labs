function [freq] = temporary()

t=0:0.001:0.999;
sig_1 = 0.5*sin(6*pi*t) + 0.1 * randn(1, 1000);
sig_2 = sign(0.5*sin(6*pi*t)) + 0.1 * randn(1, 1000);
twoplots(t, sig_1, sig_2);

%f3 = ones(1,3) / 3;
%c3_1 = conv(sig_1, f3, 'same');
%c3_2 = conv(sig_2, f3, 'same');
%twoplots(t, c3_1, c3_2);

%f15 = ones(1,15) / 15;
%c15_1 = conv(sig_1, f15, 'same');
%c15_2 = conv(sig_2, f15, 'same');
%twoplots(t, c15_1, c15_2);

%filtstat(f15);

% g3 = fspecial('gaussian', [1,  3], 1);
% cg3_1 = conv(sig_1, g3, 'same');
% cg3_2 = conv(sig_2, g3, 'same');
% twoplots(t, cg3_1, cg3_2);

% g15 = fspecial('gaussian', [1, 15], 3);
% cg15_1 = conv(sig_1, g15, 'same');
% cg15_2 = conv(sig_2, g15, 'same');
% twoplots(t, cg15_1, cg15_2);

% I=imread('cameraman.tif');
% Ia = imfilter(I, fspecial('average', 15), 'replicate'); 
% Ig = imfilter(I, fspecial('gaussian', 15, 3), 'replicate'); 
% figure('Position', [10 10 1200 300]);
% subplot(131);
% imshow(I);
% subplot(132);
% imshow(Ia);
% subplot(133);
% imshow(Ig);

[r1, lags] = xcorr(sig_1);
[r2, lags] = xcorr(sig_2);
% wycięcie jedynie dodatnich przesunięć
r1 = r1(lags >= 0);
r2 = r2(lags >= 0);
lags = lags(lags>=0);
twoplots(lags, r1, r2);

[pks, loc] = findpeaks(r1, "MinPeakDistance", 10, "MinPeakProminence", 20);

% dla nagrań pulsu 30 Hz 
fs = 1000;
% przesunięcie w sekundach
lag_s = loc(1) * 1/fs;
% częstotliwość bazowa
freq = 1/lag_s;

end




function twoplots(t, s1, s2)
    figure('Position', [10 10 1200 300]);
    subplot(121);
    plot(t, s1);
    subplot(122);
    plot(t, s2);
end

function filtstat(f)
    nfft = 1000;
    fs = 1000;
    N = 3;
    
    f_ex = zeros(1, nfft);
    f_ex(1:size(f, 2)) = f;
    
    y=fft(f_ex);
    f_base = linspace(0, fs/2, nfft/2+1);
    amp = abs(y(1:nfft/2+1));
    phase = angle(y(1:nfft/2+1));
    
    twoplots(f_base, amp, phase);
end