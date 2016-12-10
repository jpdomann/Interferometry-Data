function [ paths ] = LoadFilePaths( base_direc, shot_nums )
%LOADFILEPATHS Loads data files by searching through the folders in the
%specified directory

%identify folders
base_dir = dir(base_direc);
folders = base_dir([base_dir.isdir] &...
    ~strcmp({base_dir.name},'.') &...
    ~strcmp({base_dir.name},'..') &...
    ~strcmp({base_dir.name},'Data'));

%loop through folders and store file names
n = numel(folders);
count = 1;
for i = 1:n
    folder = folders(i);
    direc = dir([base_direc,'\',folder.name]);
    files = direc(~[direc.isdir]);
    for j = 1:numel(files)
        file = files(j);
        name = file.name;
        switch any(strfind(name,'.csv'));
            case 0
                %don't include non-csv files
            case 1
                %identify shot number of file
                switch isempty(shot_nums)
                    case 0
                        shot_no = regexp(name,'shot(\d+)_','match');
                        shot_no = str2num(shot_no{1}(5:end-1));
                        if ismember(shot_no,shot_nums)
                            paths{count} = fullfile(base_direc,folder.name,name);
                            count = count + 1;
                        end
                    case 1
                        paths{count} = fullfile(base_direc,folder.name,name);
                        count = count + 1;
                end
        end
    end
end

paths = paths';

end
