function Wrapper(str)
evalin('base',sprintf('%s;',str));
end