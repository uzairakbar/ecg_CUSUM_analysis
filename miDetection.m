function [] = miDetection( ecg, S, T )
%miDetection Extracts the ST segments from an ecg with peaks S and T and
%detects the elevation via a sequential change point algorithm; CUmulative
%SUM (CUSUM) algorithm.
%   miDetection( ecg, S, T ) Sets off an alarm at the position of the
%   relatively elevated ST segments which, although not unique to MI, are a
%   good way to detect its possible onset.

st_elevation = stElevation(ecg, S, T);  %   Extract ECG ST-elevations

%//////////////////////////////////////////////////////////////////////////

h = 2;              %   Threshold Coefficient
k = 3;              %   Minimum No. ST Elevations to detect for an alarm
window = 100;       %   Sliding window size for CUSUM algorithm
alarms = CUSUM(st_elevation, h, k, window);    %   Extract the alarm
                                               %   vector

%//////////////////////////////////////////////////////////////////////////

alarm_pos = alarms(find(alarms(:, 1) > 0), 2);      %   Locate alarm
                                                    %   positions

plot(ecg);          %   Plot the ECG, with alarms and S & T peaks
hold on
for i = 1 : 1 : length(alarm_pos)
    line([alarm_pos(i) alarm_pos(i)], get(gca,'YLim'), 'Color', [1 0 0])
end
scatter(S(:, 1), S(:, 2), 'm', 'o')
scatter(T(:, 1), T(:, 2), 'y', 'o')
hold off
title('CUSUM Alarms in ECG');
legend('ECG', 'CUSUM Alarms', 'S-Peaks', 'T-Peaks');
subplot(111)

end
