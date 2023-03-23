function filter = highpass_filter(fc, bw, fs)
    filter = lowpass(fc, bw, fs);
    M = round(fs*4/bw);

    filter = -1*filter;
    filter(M/2+1) = filter(M/2+1) + 1;
    
end