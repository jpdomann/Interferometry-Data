%John Domann
%Magnetic Effects of Laser Induced Shockwaves

%Section of program on laser shock analysis. This only includes the
%interferometry analysis

function main()

clear all
clc
set(0,'DefaultFigureWindowStyle','docked')
% addpath('subfunctions')

%% Controls

%run data calculation loop (just load from excell if false)
calculateData = true;

%Optional - Study only specific shot numbers (Leave blank to get all)
shot_nums = [];
% shot_nums = [99,100,101,110,111,112,113,146,147,149,150,151,152];

%Plot Controls
PrintOn = true;

%write data sheet
% writeOn = false;        %write data summary to excel sheet?

%% Save all current variables in an options structure to pass to functions
A = who;
for i = 1:numel(A)
    options.(A{i}) = eval(A{i});
end

%% Load data file names
file_paths = LoadFilePaths(cd,shot_nums);

%% Analyze each of the files
interferometry_file_analysis(file_paths, options);


end

