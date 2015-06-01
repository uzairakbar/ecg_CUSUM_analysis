function [processed_ecg, det] = ecgPreprocessing( ecg, Fs )
%edgPreprocessing returns a processed ecg, 'preprocessed_ecg' from input
%'ecg' with sampling frequency 'Fs'.
%   processed_ecg = ecgPreprocessing( ecg, Fs ) returns a processed ecg
%   'preprocessed_ecg', by removing noise via wavelet decomposition and
%   carrecting baseline wandering in the original ecg, 'ecg', at sampling
%   frequency 'Fs'.

[app, det] = waveletDecomposition(ecg);    %   wavelet decomposition for
                                    %   removing noise

Fs = Fs/4;                          %   downsampling due to wavelet
                                    %   decomposition

%//////////////////////////////////////////////////////////////////////////

processed_ecg = baselineCorrection(app, Fs);%   baseline wander removal

end

