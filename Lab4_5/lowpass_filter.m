function filter = lowpass_filter(fc, bw, fs)
    % fc - freq odcięcia (Hz)
    % (M+1) - dł maski (nieparzysta l. elementów)
    % M ~~ 4/BW M = 4/100/fs

    K = 1/3.1416;   % obliczone jako sum(filter)/M+1

    fc = fc/fs;     % wprowadzamy freq do funkcji jako wartosc a nie fraq.
    M = round(fs*4/bw);
    filter = zeros(M+1,1);  % inicjacja maski filtra
    for i=0:M   % nieparzysta długość maski, Okno Blackmana
        filter(i+1) = K*sin(2*pi*fc*(i-M/2))/(i-M/2)*(0.42-0.5*cos(2*pi*(i)/M)+0.08*cos(4*pi*(i)/M));
    end
    filter(M/2+1) = 2*pi*fc*K;
end