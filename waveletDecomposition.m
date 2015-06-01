function [ app, det ] = waveletDecomposition( x )
%waveletDecompositon reduces noise in a signal x via 2nd level wavelet
%decomposition. The outputs are approximation & detail coefficient vectors
%app and det respectively.
%   [ app, det ] = waveletDecomposition( x ) the process of wavelet
%   decomposition uses twin filters; one low-pass and one high-pass.
%   reduced. First level decomposition has exactly one half the samples
%   of x because the signal was decomposed in 4 levels. 2nd level has
%   exactly half number of samples that of 1st level, 3rd level has
%   exactly half number of samples than the 2nd level.
%
%   Similarly, the high-pass filter yields detail coefficient vector,
%   'det' which comtains the noise and high frequency components of the
%   signal x.

[c,l] = wavedec(x, 4, 'db4');       %   4 level wavelet decomposition by
                                    %   Daubechies-4 filter

%////////////////////////////////////////////////////////////////////////// 
 
%   To see the results of all 4 levels of app. and det. coefficients,
%   uncomment accordingly and run.

% app1 = appcoef(c, l, 'db4', 1);   %   1st level app. coefficients
app2 = appcoef(c, l, 'db4', 2);     %   2nd level app. coefficients
% app3 = appcoef(c, l, 'db4', 3);   %   3rd level app. coefficients
% app4 = appcoef(c, l, 'db4', 4);   %   4th level app. coefficients

%//////////////////////////////////////////////////////////////////////////

det1to4 = detcoef(c, l, 'db4');     %   1 to 4 level det. coefficients

det2 = cell2mat(det1to4(2));        %   2nd level det. coefficients

%//////////////////////////////////////////////////////////////////////////

app = app2;
det = det2;

%//////////////////////////////////////////////////////////////////////////

% subplot(2, 2, 1)
% plot(app1)
% title('1st Level App Coefficients')
% xlabel('1/2 samples')
% 
% subplot(2, 2, 2)
plot(app2)
title('2nd Level App Coefficients')
xlabel('1/4 samples')
% 
% subplot(2, 2, 3)
% plot(app3)
% title('3rd Level App Coefficients')
% xlabel('1/8 samples')
% 
% subplot(2, 2, 4)
% plot(app4)
% title('4th Level App Coefficients')
% xlabel('1/16 samples')

subplot(111)

end
