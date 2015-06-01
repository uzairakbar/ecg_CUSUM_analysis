function [ P, Q, R, S, T ] = ecgAnalysis( ecg, Fs, det )
%ecgAnalysis returns the P, Q, R, S, T peak locations and amplitudes of an
%ecg signal at Fs sampling frequency and detail coefficients det. Each peak
%matrix has the locations in column 1 (e.g. R(:, 1)) and amplitudes in
%column 2 (e.g. R(:, 2)).
%   [ P, Q, R, S, T ] = ecgAnalysis( ecg, Fs, det ) extract the main ECG
%   features by ?rst detecting the R peaks and their positions in the
%   signal, then we can extract the other peaks (P, Q, S, T) respectively
%   , relative to the R-peaks. R-peaks are detected by first taking the
%   detail coefficients of the original signal via 2nd level wavelet
%   decomposition. This is the squared and the positions of the maxima in a
%   sliding window of size almost equal to one pulse of the ecg signal is
%   recorded. The other peaks are located by finding the maximas and
%   minimas in the locality of the R peaks in the approximation coefficeint
%   signal.

det = det.*det.*(det >= 0);     %   Square the positive peaks of detail
                                %   coefficients and remove the negative
                                %   peaks. The R-peaks are now more evident
                                %   in detail coefficient vector.

%//////////////////////////////////////////////////////////////////////////

%   A sliding window of about 1.5 sec detects the R-peaks from the detail
%   coefficients by recording 70% of the local maximum as a possible
%   R-peak, and then removing the ones which are too close.
window = round(Fs*1.5);
max_points = [];            %   70% of the local maximum
det_peaks = [];             %   isolated peaks in det. coefficients
for i = 1 : window : (length(det) - window)
    
    M = max(det(i : (i + window)));         %   find local maximum
    if M
        max_points = find(...               %   record all points above 70%
        det(i : (i + window)) >= 0.7*M);	%   of local maximum
    else
        continue;                           %   ignore negative maximas
    end

    w_peaks = [];                           %   local window isolated peaks
    w_peaks = [w_peaks max_points(1)];
    for j = 2 : 1 : length(max_points)
        if (max_points(j) > (max_points(j - 1) + window))
            %	Find R-peaks which are atleast a window apart
            w_peaks = [w_peaks max_points(j)];
        end
    end
    
    det_peaks = [det_peaks (w_peaks + (i-1))];
    
end

%//////////////////////////////////////////////////////////////////////////

%   The detected R-peaks 'det-peaks' in det. coefficients are now located
%   in app. coefficient vector, i.e. the ecg within +-3 samples
%   for better accuracy.
P = [;];    %   P-peaks
Q = [;];    %   Q-peaks
R = [;];    %   R-peaks
S = [;];    %   S-peaks
T = [;];    %   T-peaks
for i = 1 : 1 : length(det_peaks)
	range = det_peaks(i) : (det_peaks(i) + 3);
    %   Search within a window of +-3 samples in the ecg with reference to
    %   R-locations detected in detail coefficient signal.
    M = max(ecg(range));
    location = find(ecg(range) == M);
    Rpeak = range(location);
    R = [R; [Rpeak, ecg(Rpeak)]];
end

%//////////////////////////////////////////////////////////////////////////

%   Detect other peaks with reference to R-peak locations

for j = 1 : 1 : length(R(:, 1))
    
    %   The maxima in the window of R-25 to R-3 is essentially the P peak.
    %	P - Detection    
	range = R(j, 1) - 25 : R(j, 1) - 3;
    if range(length(range)) < length(ecg)
        M = max(ecg(range));
        Ppeak = find(ecg(range) == M);
        Ppeak = Ppeak(1);
        Ppeak = range(Ppeak);
        P = [P; [Ppeak, ecg(Ppeak)]];
    end

    %//////////////////////////////////////////////////////////////////////
    
    %   The minima in the window of R-19 to R-3 is essentially the Q peak.
    %	Q - Detection
    range = R(j, 1) - 6 : R(j, 1)-3;
    if range(length(range)) < length(ecg)
        m = min(ecg(range));
        Qpeak = find(ecg(range) == m);
        Qpeak = Qpeak(1);
        Qpeak = range(Qpeak);
        Q = [Q; [Qpeak, ecg(Qpeak)]];
    end
    
    %//////////////////////////////////////////////////////////////////////
    
    %   With similar logic you can detect the S and T peaks.
    %	S - Detection
    range = R(j, 1) + 1 : R(j, 1) + 5;
    if range(length(range)) < length(ecg)
        m = min(ecg(range));
        Speak = find(ecg(range) == m);
        Speak = Speak(1);
        Speak = range(Speak);
        S = [S; [Speak, ecg(Speak)]];
    end
    
    %//////////////////////////////////////////////////////////////////////
    
    %	T - Detection
    range = R(j, 1) + 6 : R(j, 1) + 25;
    if range(length(range)) < length(ecg)
        M = max(ecg(range));
        Tpeak = find(ecg(range) == M);
        Tpeak = Tpeak(1);
        Tpeak = range(Tpeak);
        T = [T; [Tpeak, ecg(Tpeak)]];
    end
end

%//////////////////////////////////////////////////////////////////////////

%   Plot the ecg and all the peaks
plot(1:length(ecg), ecg, 'b')
hold on
scatter(P(:, 1), P(:, 2), 'c', 'o')
scatter(Q(:, 1), Q(:, 2), 'g', 'o')
scatter(R(:, 1), R(:, 2), 'r', 'o')
scatter(S(:, 1), S(:, 2), 'm', 'o')
scatter(T(:, 1), T(:, 2), 'y', 'o')
legend('ECG', 'P', 'Q', 'R', 'S', 'T')
hold off
title('ECG with extracted P, Q, R, S, T peaks');

subplot(111)

end