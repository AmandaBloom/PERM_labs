function filter = highpass(x, fc, bw, fs)
    filter = lowpass(x, fc, bw, fs);
    M = round(fs*4/bw);

    filter = -1*filter;
    filter(M/2+1) = filter(M/2+1) + 1;
    
end