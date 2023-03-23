function filter = lowpass(x, fc, bw, fs)

    % fc - freq odcięcia (Hz)
    % M - dł maski (nieparzysta l. elementów)
    % M ~~ 4/BW M = 4/100/fs

    K = 1;
    %fs = 16000;
    %fc = 0.1;
    fc = fc/fs;
    %bw = 100;
    M = round(fs*4/bw);
    filter = zeros(M,1);
    for i=1:M
        filter(i) = K*sin(2*pi*fc*(i-1-M/2))/(i-1-M/2)*(0.42-0.5*cos(2*pi*(i-1)/M)+0.08*cos(4*pi*(i-1)/M));
    end
    filter(M/2+1) = 2*pi*fc*K;    
    %filter = filter((M/2)+1-bw:(M/2)+1+bw);


end