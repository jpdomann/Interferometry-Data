classdef interferom_data_options
    %INTERFEROM_DATA_OPTIONS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        t_start;
        t_stop;
        f_cutoff;
        min_prom;
        max_prom
    end
    
    methods
        function obj = interferom_data_options(shot_no)
            switch shot_no
                case 99
                    obj.t_start = 6e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 2e8;
                    obj.min_prom = 5e-2;
                    obj.max_prom = 5e-2;
                case 100
                    obj.t_start = 6e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 1e8;
                    obj.min_prom = 2e-2;
                    obj.max_prom = 2e-2;
                case 101
                    obj.t_start = 6e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 2e8;
                    obj.min_prom = 5e-2;
                    obj.max_prom = 5e-2;                    
                case 110
                    obj.t_start = 5e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 2e8;
                    obj.min_prom = 5e-2;
                    obj.max_prom = 5e-2;
                case 111
                    obj.t_start = 5e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 2e8;
                    obj.min_prom = 5e-2;
                    obj.max_prom = 5e-2;
                case 112
                    obj.t_start = 5e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 2e8;
                    obj.min_prom = 5e-2;
                    obj.max_prom = 5e-2;     
                case 113
                    obj.t_start = 5e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 2e8;
                    obj.min_prom = 5e-2;
                    obj.max_prom = 5e-2;    
                case 146
                    obj.t_start = 1e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 1e8;
                    obj.min_prom = 1.5e-2;
                    obj.max_prom = 1.5e-2;    
                case 147
                    obj.t_start = 1e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 1.3e8;
                    obj.min_prom = 1e-2;
                    obj.max_prom = 1e-2;  
                case 149
                    obj.t_start = 0.5e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 1.3e8;
                    obj.min_prom = 3e-2;
                    obj.max_prom = 3e-2;       
                case 150
                    obj.t_start = 0.5e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 1.3e8;
                    obj.min_prom = 2e-2;
                    obj.max_prom = 2e-2;  
                case 151
                    obj.t_start = 0.6e-6;
                    obj.t_stop = obj.t_start + 0.6e-6;
                    obj.f_cutoff = 5e8;
                    obj.min_prom = 2e-2;
                    obj.max_prom = 2e-2;                      
                case 152
                    obj.t_start = 0.6e-6;
                    obj.t_stop = obj.t_start + 0.6e-6;
                    obj.f_cutoff = 5e8;
                    obj.min_prom = 2e-2;
                    obj.max_prom = 2e-2;                      
                otherwise
                    obj.t_start = 5e-6;
                    obj.t_stop = obj.t_start + 5e-6;
                    obj.f_cutoff = 2e8;
                    obj.min_prom = 5e-2;
                    obj.max_prom = 5e-2;
            end
        end
    end
    
end

