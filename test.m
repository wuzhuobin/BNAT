mfilename('fullpath');
strings = strsplit(mfilename('fullpath'), '\');
strrm = strings{end};
pathname = strrep(mfilename('fullpath'), strcat('\',strrm), '');
pathname = strcat(pathname, '\bin');
path(path, pathname);