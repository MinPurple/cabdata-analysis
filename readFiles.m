%��ȡ�����ļ�
function cab_dataset = readFiles(file_path)
%namelist  = dir('\cabspottingdata\new*.txt');
namelist  = dir(file_path);
length_of_file = length(namelist);
cab_dataset = cell(1,length_of_file); %����һ��1*l��Ԫ������,�洢���е��ļ�
for i = 1:length_of_file
    cab_dataset{1,i} = load(namelist(i).name);
end