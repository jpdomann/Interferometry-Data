classdef interferom_data < handle
    %INTERFEROM_DATA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (GetAccess = 'public', SetAccess = 'protected')
        file;   %file name
        shot_no;%shot number
        t;      %time
        v;      %voltage
        t_seg;  %segment of data
        v_seg;  %segment of data
        t_filt; %filtered data
        v_filt;  %filtered data
        
        t_peaks;%location of peak data
        v_peaks;
        t_peaks_low;
        v_peaks_low;
        t_peaks_high;
        v_peaks_high;
        
        min_prom; %prominence of min peaks
        max_prom; %prominence of max peaks
        
        t_start;%start time
        t_stop; %stop time
        f_cutoff;%cutoff frequency
        
    end
    
    properties (Access = 'public')
        
    end
    
    properties (Access = 'protected')
        dat_opts;
        filt_obj;
    end
    
    methods (Access = 'public')
        % Default constructor
        function obj = interferom_data(file_name)
            %store file name
            obj.file = file_name;
            
            %get shot number
            shot_str = regexp(file_name,'shot(\d+)_','match');
            obj.shot_no = str2double(shot_str{1}(5:end-1));
            
            %get / store data
            data = csvread(file_name,0,3);
            obj.t = data(:,1);   %time
            obj.v = data(:,2);   %voltage
            
            %load shot specific optoins
            obj.dat_opts = interferom_data_options(obj.shot_no);
            obj.assign_options();
        end
        
        % Assign options structure
        function obj = assign_options(obj)
            field_names = fieldnames(obj.dat_opts);
            for i = 1:numel(field_names)
                name = field_names{i};
                obj.(name) = obj.dat_opts.(name);
            end
        end
        
        %segment data
        function obj = segment_data(obj)
            obj.t_seg = obj.t(obj.t>obj.t_start & obj.t < obj.t_stop);
            obj.v_seg = obj.v(obj.t>obj.t_start & obj.t < obj.t_stop);
        end
        
        %filter data
        function obj = filter_data(obj)
            obj.filt_obj = designfilt('lowpassfir', ...        % Response type
                'FilterOrder',150, ...            % Filter order
                'PassbandFrequency',.8*obj.f_cutoff, ...  % Frequency constraints
                'StopbandFrequency',obj.f_cutoff, ...
                'DesignMethod','ls', ...  % Design method
                'PassbandWeight',1, ...   % Design method options
                'StopbandWeight',1, ...
                'SampleRate',1/mean(diff(obj.t_seg))...% Sample rate
                );
            obj.t_filt = obj.t_seg;
            obj.v_filt = filtfilt(obj.filt_obj,obj.v_seg);
        end
        
        %find peaks
        function obj = peaks(obj)
            [obj.v_peaks_high,obj.t_peaks_high] = findpeaks(obj.v_filt,obj.t_filt,'MinPeakProminence',obj.max_prom);
            [v_pks_low,obj.t_peaks_low] = findpeaks(-obj.v_filt,obj.t_filt,'MinPeakProminence',obj.min_prom);
            obj.v_peaks_low = -v_pks_low;
            
            %combine and sort peaks
            [obj.t_peaks,ind] = sort([obj.t_peaks_high; obj.t_peaks_low]);
            v_pks = [obj.v_peaks_high; obj.v_peaks_low];
            obj.v_peaks = v_pks(ind);
            
%             %make same size as segmented and filtered arrays
%             temp = NaN(size(obj.t_seg));
%             temp(1:numel(obj.t_peaks)) = obj.t_peaks;
%             obj.t_peaks = temp;
%             temp(1:numel(obj.v_peaks)) = obj.v_peaks;
%             obj.v_peaks = temp;
            
        end
        
        %plot results
        function obj = combined_plot(obj)
            clf
            h = plot(obj.t_seg,obj.v_seg,...
                obj.t_filt,obj.v_filt,...
                obj.t_peaks_low, obj.v_peaks_low,'r^',...
                obj.t_peaks_high, obj.v_peaks_high,'rv','MarkerFaceColor','r');
            ax = gca;     
            xlims = ax.XLim;
            hold all                 
            h(end+1) = plot(obj.t,obj.v,'Color',[ 0.8500    0.3250    0.0980]);
            h(2).Color = [0.1529    0.7216    0.0588];
            h(2).LineWidth=1.5;
            ax.XLim = xlims;            
            legend('Segment',...
                'Filtered',...
                'Low Fringe',...
                'High Fringe',...
                'Raw Data',...
                'Location','NorthWest')
            uistack(h(end),'bottom')
        end
        
        %Set Access
        function obj = set_f_cutoff(obj,input)
            obj.f_cutoff = input;
        end
    end
    
    methods (Access = 'protected')
        
    end
end

