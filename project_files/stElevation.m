function st_elevation = stElevation( ecg, S, T )
%stElevation returns a vector of st-elevaations and their locations in the
%input ecg with S and T peaks.
%   st_elevation = stElevation( ecg, S, T ) S-Offset and T-Onset is used to
%   extract an st-segment from a single QRS complex. The amplitudes and
%   locations of these extracted st-segments is recorded in a vector
%   st_elevation.

st_elevation = [;];

for j = 1 : 1 : min(length(S(:, 1)), length(T(:, 1)))
	SOff = S(j, 1) + 2;             %   S-Offset
    TOn = T(j, 1) - 2;              %   T-Onset

    st_segment = SOff : 1 : TOn;    %   st-segment
	if length(st_segment) > 0       %   check if st-segment is within ecg
    	if st_segment(length(st_segment)) < length(ecg)
        	
            st_elevation = [st_elevation;...    %record the average,
            [mean(max(ecg(st_segment), 0)...    %positive amplitude of the
            - max(min(ecg(st_segment)), 0)),...  %st-segment and st-segment
            round(mean(SOff, TOn))]];	%location in the ecg
        
        end
	end
end

%//////////////////////////////////////////////////////////////////////////

plot(st_elevation(:, 1));
title('ST Elevation Spectrum');
xlabel('Nth ST-Segment in Original ECG');
ylabel('Elevation');
subplot(111)

end