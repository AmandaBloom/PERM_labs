function filter = lowpass_filter(fc, bw, fs)

    % fc - freq odcięcia (Hz)
    % M - dł maski (nieparzysta l. elementów)
    % M ~~ 4/BW M = 4/100/fs

    K = 1/3.1416;
    %fs = 16000;
    %fc = 0.1;
    fc = fc/fs;
    %bw = 100;
    M = round(fs*4/bw);
    filter = zeros(M+1,1);
    for i=0:M
        filter(i+1) = K*sin(2*pi*fc*(i-M/2))/(i-M/2)*(0.42-0.5*cos(2*pi*(i)/M)+0.08*cos(4*pi*(i)/M));
    end
    filter(M/2+1) = 2*pi*fc*K;    
    %filter = filter((M/2)+1-bw:(M/2)+1+bw);


end