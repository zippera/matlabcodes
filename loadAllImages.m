function image_names = loadAllImages(folder, forMat)

  files = dir([folder '*' forMat]);

  nm = {files.name};
  S = sprintf('%s,', nm{:});
  D = sscanf(S, ['%d' forMat ',']);
  [~, sortIndex] = sort(D);
  sorted_nm = nm(sortIndex);

  image_names = cell(length(files), 1);

  for it_f = 1 : length(files)
    image_names{it_f} = [folder sorted_nm{it_f}];
  end