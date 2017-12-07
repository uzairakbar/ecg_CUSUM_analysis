function bc_sig = baselineCorrection( x, Fs )
%baselineCorrection removes the baseline
%wandering in a raw ecg signal x, at sampling frequency Fs, and returns
%the corrected signal bc_sig.
%   bc_sig = baselineCorrection( x, Fs ) the raw ECG signal x, with
%   sampling frequency Fs, is first filtered with an FIR low pass filter.
%   Second, the filtered signal is passed through a 200 ms median filter to
%   eliminate the QRS complex and then again through a 600 ms median filter
%   to remove the T wave. Then, this signal is subtracted from the low
%   passed filtered signal. The difference between the two signals will
%   constitute the ECG signal corrected of baseline wander, bc_sig.

Wn = 0.01;                  %	cutt-off frequency for low-pass FIR filter
a = 1;                      %   coefficient a of FIR filter
b = fir1(200, Wn, 'low');   %   coefficient b of N=200th order FIR filter

fir_x = filter(b, a, x);    %   Filtering signal 'x'

%//////////////////////////////////////////////////////////////////////////

%   median filtering with order = 3 and block-size = 200 msec
med1_x = medfilt1(fir_x, 3, round(Fs*(2/10)));

%//////////////////////////////////////////////////////////////////////////

%   median filtering with order = 3 and block-size = 600 msec
med2_x = medfilt1(med1_x, 3, round(Fs/4*(6/10)));

%//////////////////////////////////////////////////////////////////////////

%   adjusting the base-line by removing shifted phase due
%   to filtering
offset = 100;
base = [med2_x(offset + 1:length(med2_x));...
    med2_x(length(med2_x) - offset + 1: length(med2_x))];

%//////////////////////////////////////////////////////////////////////////

%   finally, correcting the wandering baseline by subtracting from 'x'
bc_sig = x - base;

%//////////////////////////////////////////////////////////////////////////

subplot(2, 1, 1)
plot(x)
hold on
plot(base, 'red', 'LineWidth', 3)
hold off
legend('RAW ECG', 'Base Line')
title('Wandering Baseline')

subplot(2, 1, 2)
plot(bc_sig)
title('Baseline Corrected Signal')

subplot(111)

end