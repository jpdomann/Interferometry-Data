function [ output_args ] = interferometry_file_analysis( file_paths, options )
%INTERFEROMETRY_FILE_ANALYSIS analyzes each of the included files
%   Detailed explanation goes here

nfiles = numel(file_paths);
%% Analyze Data
dat_array = cell(1,nfiles);
for i = 1:nfiles
    %%
    %Load data
    file = file_paths(i);
    dat = interferom_data(file{1});
    
    %Segment / Filter Data
    dat.segment_data();
    dat.filter_data();
    
    %Get peaks
    dat.peaks();
    
    %store
    dat_array{i} = dat;
end

%% Output Data
for i = 1:nfiles
    %% Figures
    dat = dat_array{i};
    %show results
    dat.combined_plot();
    drawnow
    if options.PrintOn
        saveas(gcf,['FIG Files\Shot_',num2str(dat.shot_no)],'fig')
        print(gcf,['PNG\Shot_',num2str(dat.shot_no)],'-dpng','-r200')
    end
    
    %% Spreadsheet
    %write header
    header = {'t_seg','v_seg','t_filt','v_filt',...
        't_pks','v_pks'};
    dat_cell = {dat.t_seg, dat.v_seg,...
        dat.t_filt, dat.v_filt,...
        dat.t_peaks, dat.v_peaks};
    
    %write data
    write_csv(['Reduced Data\Shot_',num2str(dat.shot_no),'.csv'],header,dat_cell)
    
end
%     T = table(dat.t_seg, dat.v_seg,...
%         dat.t_filt, dat.v_filt,...
%         dat.t_peaks, dat.v_peaks);
%     T.Properties.VariableNames = header;
%     writetable(T,['Data\Shot_',num2str(dat.shot_no),'.csv'])

end