function alarms = CUSUM( st_elevation, h, k, w )
%CUSUM Summary of this function goes here
%   alarms = CUSUM( st_elevation, h, k, w ) explanation goes here

alpha = 4;
G = 0;
window = st_elevation(1:w , 1);
A = zeros(w, 1);
V = var(st_elevation(:, 1));
u = mean(window);

alarms = zeros(length(st_elevation(:, 1)), 2);

for i = 1 : 1 : length(st_elevation(:, 1)) - window
    
    temp = G;
    G = max(0, (G + (((u*(alpha - 1))/V)...
        *(window((length(window)*.5) + 1)...
        - ((u*(alpha - 1))/2)))));
    
    if G >= h
        
       A(length(A)) = 1;
       if (sum(A) >= k)
           alarms(i+(w/2), 1:2) = [1, st_elevation(i ,2)];
           G = 0;
       else
           G = temp;
       end
       
    else
        if G <= 0
            G = 0;
        end
    end
    
    loc = find(A == 0);
    u = mean(window(loc));
    
    window = circshift(window, [-1 0]);
    if i+1 < length(st_elevation(:, 1))
        window(length(window)) = st_elevation(i + 1, 1);
    else
        window(length(window)) = 0;
    end
    
    A = circshift(A, [-1 0]);
    A(length(A)) = 0;
end

%//////////////////////////////////////////////////////////////////////////

alarm_pos = find(alarms(:, 1) > 0);

plot(st_elevation(:, 1));
hold on
for i = 1 : 1 : length(alarm_pos)
    line([alarm_pos(i) alarm_pos(i)], get(gca,'YLim'), 'Color', [1 0 0])
end
hold off
title('CUSUM Alarms in ST Elevation Spectrum');
legend('ECG', 'CUSUM Alarms');
subplot(111)

end