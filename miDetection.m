function [] = miDetection( ecg, S, T )
%miDetection Summary of this function goes here
%   miDetection( ecg, S, T ) explanation goes here

st_elevation = stElevation(ecg, S, T);

%//////////////////////////////////////////////////////////////////////////

h = 2;
k = 3;
window = 100;
alarms = CUSUM(st_elevation, h, k, window);

%//////////////////////////////////////////////////////////////////////////

% alarm_pos = alarms(find(alarms(:, 1) > 0), 2);
% 
% plot(ecg);
% hold on
% for i = 1 : 1 : length(alarm_pos)
%     line([alarm_pos(i) alarm_pos(i)], get(gca,'YLim'), 'Color', [1 0 0])
% end
% hold off
% title('CUSUM Alarms in ECG');
% legend('ECG', 'CUSUM Alarms');
% subplot(111)

end